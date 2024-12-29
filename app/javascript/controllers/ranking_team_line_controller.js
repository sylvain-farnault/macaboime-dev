import { Controller } from "@hotwired/stimulus"
import { getCookie } from "../helpers/cookie_helper"

// Connects to data-controller="ranking-team-line"
export default class extends Controller {
  static targets = []

  connect() {
    const registeredFavoriteTeam = getCookie('favorite_team');

    if (this.element.dataset.teamId == registeredFavoriteTeam) {
      this.element.classList.add("favorite-team");
    } else {
      this.element.classList.remove("favorite-team");
    }
  }

  disconnect() {
    // console.log('Disconnect ranking-team-line')
  }
  
}
