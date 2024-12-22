class PreferencesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:update] 

  def update
    cookies[:__Secure_necessary_cookies_agreement] = {
      value: true,
      expires: 1.year.from_now,
      same_site: :strict,
      secure: true,
      httponly: false,
      essential: true
    }
    cookies.permanent[:favorite_team] = params[:favorite_team]
    cookies.permanent[:always_show_stadium] = params[:always_show_stadium]
		
    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end
end
