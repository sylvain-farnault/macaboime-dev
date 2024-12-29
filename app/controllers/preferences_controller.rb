class PreferencesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:update, :cookies_refusal] 

  def update
    # TODO: HTTPS / secure: true / __Secure_necessary_cookies_agreement
    cookies[:necessary_cookies_agreement] = {
      value: true,
      expires: 1.year.from_now,
      same_site: :strict,
      secure: false,
      httponly: false,
      essential: true
    }
    cookies.permanent[:favorite_team] = params[:favorite_team]
    cookies.permanent[:always_show_stadium] = params[:always_show_stadium]
		
    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end

  def cookies_refusal
    cookies[:necessary_cookies_agreement] = {
      value: false,
      expires: 1.year.from_now,
      same_site: :strict,
      secure: false,
      httponly: false,
      essential: true
    }
    cookies.delete(:favorite_team)
    cookies.delete(:always_show_stadium)

    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end
end
