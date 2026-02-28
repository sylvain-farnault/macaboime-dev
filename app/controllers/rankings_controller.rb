class RankingsController < ApplicationController
  before_action :authenticate_user!

  # app/controllers/rankings_controller.rb
  def create_initial
    # On utilise find_by pour la target pour avoir un nil si pas d'Edition selctionnée
    # C'est un raccourci facile pour permettre de "supprimer" un ranking initial pour une édition
    target_edition = Edition.find_by(id: params[:target_edition_id])
    edition = Edition.find(params[:edition_id])
    if edition
      edition.rankings.create!(
        data: target_edition ? target_edition.ranking_datas : {}, 
        initial: true
      )
    end
    redirect_to editions_path, notice: "Classement initial créé avec succès pour l'édition #{target_edition&.designation}."
  rescue ActiveRecord::RecordNotFound
    redirect_to request.referer, alert: "Édition non trouvée."
  end

end