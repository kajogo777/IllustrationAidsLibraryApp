class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?

  def index

    @locations = Location.all
    @nlocation = Location.new

  end

  def get_location

    loca = params[:loc1]
    locb = params[:loc2]
    locc = params[:loc3]

    unless loca == nil || loca == ""
      @cur_loc = Location.where(loc1: loca) 
      @cur_loc = @cur_ser.where(loc2: locb) unless locb == nil || locb == ""
      @cur_loc = @cur_ser.where(loc3: locc) unless locc == nil || locc == ""
      
      if @cur_loc.count > 1
        @cur_loc = nil
      else
        @cur_loc = @cur_loc.first 
      end
    end

      @items = @cur_loc.items unless @cur_loc.blank?

  end

  def create
    @location = Location.new(location_params)

    @str = nil
    @alert = nil

    if @location.save
      @str = 'Location was successfully created'
      @alert = 'panel-success'
    else
      @str = @location.errors.full_messages
      @alert = 'panel-danger'
      @location = nil
    end

  end

  def update
    @str = nil
    @alert = nil
    @locid = @location.id

    if @location.update(location_params)
      @str = 'Location was successfully updated'
      @alert = 'panel-success'
    else
      @str = @location.errors.full_messages
      @alert = 'panel-danger'
      @location = nil
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @locid = params[:id]
    Location.destroy(@locid)
  end

  def close_new_modal
    @nlocation = Location.new
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:loc1, :loc2, :loc3, :description)
    end
end
