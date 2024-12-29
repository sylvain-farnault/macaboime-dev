import { Controller } from "@hotwired/stimulus"
import { Modal } from 'bootstrap'
import { getCookie } from "../helpers/cookie_helper"

export default class extends Controller {
  static targets = ["form", "closeModal", "showStadiumYes", "showStadiumNo", "favoriteTeam", "refusalButton"]
  token = null;

  connect() {
    this.modal = new Modal(this.element)
    // console.log("getCookie('necessary_cookies_agreement') :", getCookie('necessary_cookies_agreement'), typeof(getCookie('necessary_cookies_agreement')))
    
    this.token = this.setToken();

    if (!getCookie('necessary_cookies_agreement')) {
      this.modal.show()
    }
    // Persistence favorite_team preference
    const registeredFavoriteTeam = getCookie('favorite_team');
    this.favoriteTeamTarget.value = registeredFavoriteTeam;
    // TODO: extract persistence in an updatePersistenceForm method...
    // ...that could be called in connect and submit (or elsewhere!)

    const registeredShowStadium = getCookie('always_show_stadium');
    if (registeredShowStadium === "true") {
      this.showStadiumYesTarget.checked = true;
    } else if (registeredShowStadium === "false") {
      this.showStadiumNoTarget.checked = true;
    } else {
      this.showStadiumYesTarget.checked = false;
      this.showStadiumNoTarget.checked = false;
    }
    console.log("Cookies: ",registeredFavoriteTeam, registeredShowStadium);
  }

  submit(event) {
    event.preventDefault()
    console.log("Submit options form")
    
    fetch(this.formTarget.action, {
      method: 'POST',
      body: JSON.stringify(Object.fromEntries(new FormData(this.formTarget))),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': `Bearer ${this.token}`,
        "Authorization": `Bearer ${this.token}`
      }
      // credentials: 'same-origin'  // Pour inclure les cookies
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        document.body.focus();
        this.closeModalTarget.click();
        this.reconnectController("ranking-team-line");
        this.reconnectController("games");
      }
    })
    .catch(error => console.error('Error:', error))
  }

  cookiesRefusal() {
    // Set necessary_cookies_agreement to false
    // Delete always_show_stadium and favorite_team
    fetch(this.refusalButtonTarget.dataset.refusalUrl, {
      method: 'POST',
      body: JSON.stringify(Object.fromEntries(new FormData(this.formTarget))),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': `Bearer ${this.token}`,
        "Authorization": `Bearer ${this.token}`
      }
      // credentials: 'same-origin'  // Pour inclure les cookies
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        this.closeModalTarget.click();
      }
    })
    .catch(error => console.error('Error:', error))
  }

  setToken() {
    // Récupérer le token CSRF dans le DOM
    return document.querySelector('meta[name="csrf-token"]').getAttribute("content");
  }

  async reconnectController(controllerName) {
    // Disconnect with removeAttribute (we wait it's done before reconnect )
    // Reconnect with setAttribute
    const teamLines = document.querySelectorAll(`[data-controller='${controllerName}']`);
    
    const removeAndSetAttribute = async (element) => {
      return new Promise((resolve) => {
        element.removeAttribute('data-controller');
        // we wait for DOM update
        requestAnimationFrame(() => {
          element.setAttribute('data-controller', controllerName);
          resolve();
        });
      });
    };
  
    // TeamLines treatment as a sequence
    for (const teamLine of teamLines) {
      await removeAndSetAttribute(teamLine);
    }
  }
}