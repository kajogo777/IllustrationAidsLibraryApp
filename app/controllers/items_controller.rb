class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_filter :set_tags

  #autocomplete :tag, :name, full: true

  def index

    @topItems ||=  Item.select("items.id, items.name, items.description, items.condition, items.category_id, items.sub_category_id
      , items.photo , count(check_ins.id) AS checkins_count").
    joins(:check_ins).group("items.id").
    order("checkins_count DESC").limit(10)

    @items = if params[:sort] == nil
      Item.page(params[:page]).per_page(10)
    else
      Item.includes(:category).order(params[:sort] + ' ' + params[:direction]).page(params[:page]).per_page(10)
    end

    @nitem = Item.new

  end

  def update

    @str = nil
    @alert = nil
    @itmid = @item.id

    if @item.update(item_params)
      @str = 'Item was successfully updated'
      @alert = 'panel-success'
    else
      @str = @item.errors.full_messages
      @alert = 'panel-danger'
      @item = nil
    end
  end

  def create
    @item = Item.new(item_params)

    @str = nil
    @alert = nil

    if @item.save
      @str = 'Item was successfully created'
      @alert = 'panel-success'
    else
      @str = @item.errors.full_messages
      @alert = 'panel-danger'
      @item = nil
    end

  end

  def get_item
    itemID = params[:itemID].to_i

    @cur_item = nil
    @services = nil
    
    if itemID > 0
      @cur_item = Item.where(id: itemID).first
      @services = Service.select([:id,:name,:sub_name,"count(check_ins.id) AS checkins"])
      .joins(people: :check_ins).where(check_ins: {item_id: itemID}).group("services.id")
    end
  end

  def get_sub

    @subs = (Category.find(params[:cat_id].to_i)).sub_categories
    @tagid = params[:tagid]

  end


  def show
  end

  def new
    @item = Item.new
  end

  def destroy

    @itmid = params[:id]
    Item.destroy(@itmid)

  end

  def close_new_modal
    @nitem = Item.new
  end

  def get_pdf
    allItems = Item.all

    pdf = ItemsPdf.new(allItems, view_context)
    send_data pdf.render, filename: 
    "Items_List_#{Time.now.to_i}.pdf",
    type: "application/pdf"
    #disposition: inline #open in browser
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:photo, :name, :description, :cost, :condition, :category_id, :sub_category_id, :location_id, tag_ids: [])
    end

    def set_tags
      @tags = Tag.all
    end
end
