class PreferencesController < ApplicationController
	def update
		cookies.permanent[:cookie_agreement] = true
		cookies.permanent[:favorite_team] = params[:favorite_team]
		cookies.permanent[:always_show_stadium] = params[:always_show_stadium]

		respond_to do |format|
			format.json { render json: { success: true } }
		end
	end
end
