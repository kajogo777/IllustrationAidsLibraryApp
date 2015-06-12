class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :is_super_admin?

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
    @nrole = Role.new
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    @str = nil
    @alert = nil

    if @role.save
      @str = 'Role was successfully created'
      @alert = 'panel-success'
    else
      @str = @role.errors.full_messages
      @alert = 'panel-danger'
      @role = nil
    end

  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    @str = nil
    @alert = nil
    @rolid = @role.id

    if @role.update(role_params)
      @str = 'Role was successfully updated'
      @alert = 'panel-success'
    else
      @str = @role.errors.full_messages
      @alert = 'panel-danger'
      @role = nil
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @rolid = params[:id]
    Role.destroy(@rolid)
  end

  def close_new_modal
    @nrole = Role.new
  end

  def get_rolpeople
    rolname = params[:rolename]
    rol = Role.find_by(name: rolname) unless rolname == nil || rolname == ""
    @people = rol.people unless rol == nil
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :description)
    end
end
