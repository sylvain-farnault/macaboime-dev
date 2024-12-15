import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["stadium", "mainContent", "button", "score"]

  connect() {
    this.checkScreenWidth()
    window.addEventListener('resize', this.checkScreenWidth.bind(this))

    if (this.getCookie('always_show_stadium') === 'true') {
      this.expand()
    }
  }

  disconnect() {
    window.removeEventListener('resize', this.checkScreenWidth.bind(this))
  }

  checkScreenWidth() {
    this.isNarrowScreen = window.innerWidth < 768
  }

  toggle() {
    const isExpanded = this.mainContentTarget.classList.contains('expanded')
    
    if (isExpanded) {
      this.collapse()
    } else {
      this.expand()
    }
  }

  expand() {
    const heightMatchContainer = getComputedStyle(document.documentElement).getPropertyValue('--height-match-container')
    const baseFontSize = getComputedStyle(document.documentElement).getPropertyValue('--base-font-size')
    this.stadiumTarget.style.opacity = "1"
    this.mainContentTarget.style.width = `calc(100% - ${this.stadiumTarget.offsetWidth - (parseFloat(heightMatchContainer)*parseFloat(baseFontSize))}px)`
    this.mainContentTarget.classList.add('expanded')
    this.buttonTarget.classList.add('active')
    this.buttonTarget.querySelector("i.fa").classList.add("fa-angle-double-right")
    this.buttonTarget.querySelector("i.fa").classList.remove("fa-angle-double-left")
    this.buttonTarget.style.backgroundColor = "rgba(200, 200, 200, 1)";
    this.scoreTarget.style.marginLeft = 0;
    this.scoreTarget.style.marginRight = 0;

    // this.mainContentTarget.querySelectorAll(".team").forEach(team => {
    //   team.querySelector(".team-name-full").style.display = "none";
    //   team.querySelector(".team-name-short").style.display = "inline";
    // });

    // if (this.isNarrowScreen && this.hasScoreTarget) {
    //   this.scoreTarget.classList.add('hidden')
    // }
  }

  collapse() {
    this.stadiumTarget.style.opacity = "0"
    this.mainContentTarget.style.width = "100%"
    this.mainContentTarget.classList.remove('expanded')
    this.buttonTarget.classList.remove('active')
    this.buttonTarget.style.backgroundColor = "rgba(200, 200, 200, 0.2)";
    this.buttonTarget.querySelector("i.fa").classList.add("fa-angle-double-left")
    this.buttonTarget.querySelector("i.fa").classList.remove("fa-angle-double-right")
    this.scoreTarget.style.marginLeft = "1rem";
    this.scoreTarget.style.marginRight = "1rem";

    // this.mainContentTarget.querySelectorAll(".team").forEach(team => {
    //   team.querySelector(".team-name-full").style.display = "inline";
    //   team.querySelector(".team-name-short").style.display = "none";
    // });

    // if (this.isNarrowScreen && this.hasScoreTarget) {
    //   this.scoreTarget.classList.remove('hidden')
    // }
  }

  getCookie(name) {
    const value = `; ${document.cookie}`
    const parts = value.split(`; ${name}=`)
    if (parts.length === 2) return parts.pop().split(';').shift()
  }
}