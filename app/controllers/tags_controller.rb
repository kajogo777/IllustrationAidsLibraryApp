class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?

  def index

    @topTags ||= Tag.select(:name, "count(check_ins.id) AS checkins_count")
    .joins(items: :check_ins).group("tags.id").order("checkins_count DESC").limit(10)

    @tags = Tag.all.page(params[:page]).per_page(10).order(:name)

    @ntag = Tag.new

  end


  def show
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    @str = nil
    @alert = nil

    if @tag.save
      @str = 'Tag was successfully created'
      @alert = 'panel-success'
    else
      @str = @tag.errors.full_messages
      @alert = 'panel-danger'
      @tag = nil
    end

  end


  def update
    @str = nil
    @alert = nil
    @tagid = @tag.id

    if @tag.update(tag_params)
      @str = 'Tag was successfully updated'
      @alert = 'panel-success'
    else
      @str = @tag.errors.full_messages
      @alert = 'panel-danger'
      @tag = nil
    end
  end

  def close_new_modal
    @ntag = Tag.new
  end


  def destroy
    @tagid = params[:id]
    Tag.destroy(@tagid)
  end

  def get_tag
    tag_name = params[:tagName]

    @cur_tag = nil
    @services = nil
    
    if tag_name
      @cur_tag = Tag.where(name: tag_name).first
      @services = Service.select([:id,:name,:sub_name,"count(check_ins.id) AS checkins"])
      .joins(people: :check_ins).where(check_ins: {item_id: @cur_tag.items}).group("services.id").order('count(check_ins.id) DESC')
    end
  end

  def get_pdf
    alltags = Tag.all

    pdf = TagsPdf.new(alltags, view_context)
    send_data pdf.render, filename: 
    "Tags_List_#{Time.now.to_i}.pdf",
    type: "application/pdf"
    #disposition: inline #open in browser

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
