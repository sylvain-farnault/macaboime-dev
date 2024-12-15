// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Configure your import map in config/importmap.rb ????
// Chargement de Stimulus
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
console.log("Début chargement application.js");

const application = Application.start()
// Modifier le chemin pour pointer au bon endroit
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// Rendre l'application disponible globalement
window.StimulusApplication = application

console.log("Application Stimulus chargée");


import { showSelectSchedule } from '../components/schedules'
import { markControlsHandler } from '../components/mark_controls_handler'
import { forfeitBtnHandler } from '../components/forfeit_btn_handler'

// require("jquery");
import "@popperjs/core"
import "bootstrap";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


document.addEventListener('turbolinks:load', () => {
  // Add "RED" background on admin(power) path
  if (window.location.pathname.includes("power")) {
    document.body.style.backgroundColor = "red";
  }
  if (window.location.pathname.includes("power/results")) {
    console.log("Let s go");

    // WHEN Schedule select is change : load new url for selected schedule
    const loadNewURL = (event) => {
      console.log(event.target.value);
      console.log(window.location.href);
      const url = "/power/results/"+event.target.value
      window.location.replace(url);
    }
    const schedule_select = document.querySelector("#schedule_id");
    schedule_select.addEventListener('change', loadNewURL);

    markControlsHandler();
    forfeitBtnHandler();

    const allPointsAwardInputs = document.querySelectorAll("select[name*='[points_award]']");
    allPointsAwardInputs.forEach( input => {
      input.addEventListener('change', () => {
        console.log('Pts award just changed!!!');
      });
    });
  }

  if (window.location.pathname === "/" || window.location.pathname.includes("saisons/")) {
    const activeSchedule = document.querySelector("#select-schedule > .active");
    if (activeSchedule) {
      activeSchedule.click();
    } else {
      // if last schedule is to far in past
      const allSchedulesLinks = document.querySelectorAll("#select-schedule a");
      const lastScheduleLink = allSchedulesLinks[allSchedulesLinks.length - 1];
      lastScheduleLink.classList.add("active");
      lastScheduleLink.click();
    }

    showSelectSchedule();
  }

});

require("trix")
require("@rails/actiontext")
