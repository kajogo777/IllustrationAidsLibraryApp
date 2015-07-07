class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :manage_super_admin


protected

    def manage_super_admin
      sadmin = Role.find_by(name: "SuperAdmin")
      admin = Role.find_by(name: "Admin")
      usr = Role.find_by(name: "User")

      if sadmin.blank?

        sadmin = Role.new(name: "SuperAdmin", description: "Full Access")
        sadmin.save

      end

      if admin.blank?

        admin = Role.new(name: "Admin", description: "Admin Access")
        admin.save

      end

      if usr.blank?

        usr = Role.new(name: "User", description: "reservation and requests")
        usr.save

      end

      if sadmin.people.count == 0

        p = Person.new
        p.nationalid = "11111111111111"
        p.first_name = "Temp"
        p.middle_name = "Super"
        p.last_name = "Admin"
        p.addressA = "NA"
        p.addressB = "NA"
        p.addressC = "NA"
        p.phone_number = "NA"
        p.mobile_number1 = "01000000000"
        p.role = sadmin
        p.save

        user = User.new
        user.person = p
        user.username = p.first_name + '.' + p.middle_name + '.' + p.last_name
        user.password = user.password_confirmation = p.first_name + '.' + p.middle_name + '777'
        user.email = user.username + '@stmarychurch.com'
        user.save

      end

    end

  	def is_admin?

  		unless current_user.person.role.name == "Admin" || current_user.person.role.name == "SuperAdmin"
  			flash[:alert] = "You Do Not have Access to Manage Aids!"

        redirect_to root_path

  		end

  	end

    def is_super_admin?

      unless current_user.person.role.name == "SuperAdmin"
        flash[:alert] = "You Do Not have Access to Roles!"

        redirect_to root_path 

      end

    end

  	def is_user?

  		unless current_user.person.role.name == "Servant"
  			flash[:alert] = "You Do Not have Access to User Services!"

  			redirect_to root_path
  		end

  	end

end
