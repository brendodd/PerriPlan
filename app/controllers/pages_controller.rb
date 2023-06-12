class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
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
