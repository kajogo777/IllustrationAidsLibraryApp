class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?
  
  # GET /services
  # GET /services.json
  def index

    @services = Service.all
    @nservice = Service.new
  end

  def get_service

    serv_name = params[:servname]
    serv_sub_name = params[:servsubname]

    unless serv_name == nil || serv_name == ""
      @cur_ser = Service.where(name: serv_name) 
      @cur_ser = @cur_ser.where(sub_name: serv_sub_name) unless serv_sub_name == nil || serv_sub_name == ""
      
      if @cur_ser.count > 1
        @cur_ser = nil
      else
        @cur_ser = @cur_ser.first 
      end
    end

    unless @cur_ser.blank?
      @servants = @cur_ser.people

      @items =  Item.select(:id, :description, :condition, :category_id, :sub_category_id, "count(check_ins.id) AS check_ins_count")
                    .joins(people: :check_ins)
                    .where(check_ins: {person: @servants}).group("items.id")
                    .order("check_ins_count DESC").limit(10)

      @subCategories = SubCategory.select(:id, :name, :description,"count(check_ins.id) AS checkins_count")
                               .joins(items: :check_ins)
                               .group("sub_categories.id")
                               .order("checkins_count DESC").limit(10)
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  def create
    @service = Service.new(service_params)

    @str = nil
    @alert = nil

    if @service.save
      @str = 'Service was successfully created'
      @alert = 'panel-success'
    else
      @str = @service.errors.full_messages
      @alert = 'panel-danger'
      @service = nil
    end

  end

  def update
    @str = nil
    @alert = nil
    @serid = @service.id

    if @service.update(service_params)
      @str = 'Service was successfully updated'
      @alert = 'panel-success'
    else
      @str = @service.errors.full_messages
      @alert = 'panel-danger'
      @service = nil
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @serid = params[:id]
    Service.destroy(@serid)
  end

  def close_new_modal
    @nservice = Service.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :sub_name)
    end
end
