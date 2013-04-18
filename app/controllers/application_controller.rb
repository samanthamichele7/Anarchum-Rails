class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :store_location

	def store_location
	  # store last url as long as it isn't a /users path
	  session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
	end

	def after_sign_in_path_for(resource)
	  session[:previous_url] || root_path
	end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, :alert => "You don't have access to that feature. Please try again."
  end
end
