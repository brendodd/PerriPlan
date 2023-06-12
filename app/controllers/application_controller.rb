class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :query_city
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])

    # For additional in app/views c/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number])
  end

  def query_city
    if params[:query]
      city = City.find_by("name ILIKE ?", "%#{params[:query]}%")
        if city.nil?
          flash[:notice] = "City not found"
        else
          redirect_to city_path(city)
        end
    end
  end
end
