class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?

  # GET /categories
  # GET /categories.json
  def index

    @topCategories ||=  Category.select(:id, :name, :description,"count(check_ins.id) AS checkins_count")
    .joins(items: :check_ins).group("categories.id").order("checkins_count DESC").limit(10)

    @categories = if params[:sort] == nil
      Category.all
    else
      Category.order(params[:sort] + ' ' + params[:direction])
    end

    @ncategory = Category.new

  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    @str = nil
    @alert = nil

    if @category.save
      @str = 'Category was successfully created'
      @alert = 'panel-success'
    else
      @str = @category.errors.full_messages
      @alert = 'panel-danger'
      @category = nil
    end

  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @str = nil
    @alert = nil
    @catid = @category.id

    if @category.update(category_params)
      @str = 'Category was successfully updated'
      @alert = 'panel-success'
    else
      @str = @category.errors.full_messages
      @alert = 'panel-danger'
      @category = nil
    end
  end

  def close_new_modal
    @ncategory = Category.new
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @catid = params[:id]
    Category.destroy(@catid)
  end

  def get_category
    cat_name = params[:catName]

    @cur_cat = nil
    @services = nil
    
    if cat_name
      @cur_cat = Category.where(name: cat_name).first
      @services = Service.select([:id,:name,:sub_name,"count(check_ins.id) AS checkins"])
      .joins(people: :check_ins).where(check_ins: {item_id: @cur_cat.items}).group("services.id").order('count(check_ins.id) DESC')
    end
  end

  def get_pdf
    allCategories = Category.all

    pdf = CategoriesPdf.new(allCategories, view_context)
    send_data pdf.render, filename: 
    "Categories_List_#{Time.now.to_i}.pdf",
    type: "application/pdf"
    #disposition: inline #open in browser

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description, sub_categories_attributes: [:id, :name, :description, :category_id, :_destroy])
    end
end
