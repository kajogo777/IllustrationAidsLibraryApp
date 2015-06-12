class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all.order("created_at DESC")
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = params[:id]
    Request.destroy(@request)
  end

  def get_request
    reqid = params[:reqid]
    @request = Request.find(reqid)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:person_id, :item_id, :description)
    end
end
