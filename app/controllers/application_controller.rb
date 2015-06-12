class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


protected

  	def is_admin?

  		unless current_user.person.role.name == "Admin"
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
