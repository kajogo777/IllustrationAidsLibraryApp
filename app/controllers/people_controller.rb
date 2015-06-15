class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?

  def index

    @people = if params[:sort] == nil
      Person.page(params[:page]).per_page(10)
    else
      if params[:sort] != "role.name"
        Person.order(params[:sort] + ' ' + params[:direction]).page(params[:page]).per_page(10)
      else
        Person.joins(:role).order('roles.name ' + params[:direction]).page(params[:page]).per_page(10)
      end
    end

    @nperson = Person.new

  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  def update

    @str = nil
    @alert = nil
    @perid = @person.id

    if @person.update(person_params)
      @str = 'Item was successfully updated'
      @alert = 'panel-success'
    else
      @str = @person.errors.full_messages
      @alert = 'panel-danger'
      @person = nil
    end
  end

  def create
    @person = Person.new(person_params)

    @str = nil
    @alert = nil

    if @person.save

      user = User.new
      user.person = @person
      user.username = @person.first_name.downcase + '.' + @person.middle_name.downcase + '.' + @person.last_name.downcase
      user.password = user.password_confirmation = @person.first_name.downcase + '.' + @person.middle_name.downcase + '777'
      user.email = user.username + '@stmarychurch.com'
      user.save

      @str = 'Item was successfully created'
      @alert = 'panel-success'
    else
      @str = @person.errors.full_messages
      @alert = 'panel-danger'
      @person = nil
    end

  end

  def get_person

    search_natid = params[:searchNatID]
    search_mob = params[:searchMob]
    search_namef = params[:searchFirst]
    search_namem = params[:searchMidd]
    search_namel = params[:searchLast]

    @cur_person = Person
    
    unless (search_natid == nil || search_natid == "")
      @cur_person =  @cur_person.find_by(nationalid: search_natid) 
    end
     
    unless (search_namef == nil || search_namef == "")
      @cur_person =  @cur_person.where(first_name: search_namef)
    end

    unless (search_namem == nil || search_namem == "")
      @cur_person =  @cur_person.where(middle_name: search_namem)
    end

    unless (search_namel == nil || search_namel == "")
      @cur_person =  @cur_person.where(last_name: search_namel)
    end

    unless (search_mob == nil || search_mob == "")
      @cur_person =  @cur_person.where("mobile_number1 = ? OR mobile_number2 = ?", search_mob, search_mob)
    end

    if(@cur_person == Person || @cur_person.count > 1)
      @cur_person = nil 
    else
      @cur_person = @cur_person.first
    end 


    @checkOuts = nil
    @lateCheckOuts = nil
    @topItems = nil

    unless @cur_person == nil
      
      @checkOuts = CheckOut.where(person: @cur_person)

      @lateCheckOuts = @checkOuts.where("deadline_date < ?",Time.zone.now)
      @lateCheckIns = CheckIn.where("person_id = ? AND on_deadline = ?", @cur_person.id, false)
      
      @topItems =  Item.select("items.id, items.name, items.description, items.condition, items.category_id, items.sub_category_id
                        , count(check_ins.id) AS check_ins_count")
                        .joins(people: :check_ins).where(check_ins: {person: @cur_person}).group("items.id")
                        .order("check_ins_count DESC").limit(10)
    end
    
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def close_new_modal
    @nperson = Person.new
  end

  def get_pdf
    allPeople = Person.all

    pdf = PeoplePdf.new(allPeople, view_context)
    send_data pdf.render, filename: 
    "Servants_List_#{Time.now.to_i}.pdf",
    type: "application/pdf"
    #disposition: inline #open in browser
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:nationalid, :first_name, :middle_name, :last_name, :addressA, :addressB, :addressC, :addressD, :phone_number, :mobile_number1, :mobile_number2, :role_id, service_ids: [])
    end
end
