import { Controller } from "@hotwired/stimulus"
import { Modal } from 'bootstrap'
import { getCookie } from "../helpers/cookie_helper"

export default class extends Controller {
  static targets = ["form", "closeModal"]

  connect() {
    this.modal = new Modal(this.element)
    console.log("Display preferences modal")
    console.log("getCookie('cookie_agreement') : ", getCookie('cookie_agreement'))
    if (!getCookie('cookie_agreement')) {
      this.modal.show()
    }
  }

  submit(event) {
    event.preventDefault()
    console.log("Submit options form")
    
    fetch(this.formTarget.action, {
      method: 'POST',
      body: new FormData(this.formTarget),
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        this.closeModalTarget.click();
      }
    })
  }
}