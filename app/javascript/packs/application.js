// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import { showSelectSchedule } from '../components/schedules'

// require("jquery");
// import "bootstrap";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// Add "RED" background on admin(power) path
window.addEventListener("load", event = () => {
  if (window.location.pathname.includes("power")) {
    document.body.style.backgroundColor = "red";
  }
  if (window.location.pathname.includes("power/results")) {
    console.log("Let s go");
    // change game status select style to be the same than selected option
    // ...?

    // When forfeit checkbox is changed to true: set mark values to 0 and 3
    forfeit_checkboxes = document.querySelectorAll("input[id*='_forfeit']");
    const updateMarksOnForfeit = (event) => {
      // console.log(event.target);
      const forfeit_mark = event.target.parentNode.parentNode.parentNode.querySelector("select[name*='[mark]']");
      // console.log(forfeit_mark);
      if (event.target.checked == true) {
        // debugger;
        forfeit_mark.parentNode.parentNode.parentNode.querySelectorAll("select[name*='[mark]']").forEach(mark => {
          if (mark != forfeit_mark) {
            forfeit_mark.value = 0;
            mark.value = 3;
            updatePointsAward(mark);
          }
        });
      }
    }
    forfeit_checkboxes.forEach(checkbox => checkbox.addEventListener('change', updateMarksOnForfeit));

    const updatePointsAward = (target) => {
      current_mark = target;
      // console.log(current_mark);
      // console.log(typeof(target));
      // console.log('dddddddddddddddddddddddddddddd');
      if (current_mark.value) {
        // Get game_marks (the 2 opponents marks)
        game_marks = current_mark.parentNode.parentNode.parentNode.querySelectorAll("select[name*='[mark]']");
        game_marks.forEach(mark => {
          // If opponent_mark not null && mark is the opponent mark
          if (mark != current_mark && mark.value != "") {
            // Compare marks
            if (parseInt(mark.value) > parseInt(current_mark.value)) {
              // set opponnent 3 pts and current 0 pt
              mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 3;
              current_mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 0;
            } else if (parseInt(mark.value) < parseInt(current_mark.value)) {
              // set current 3 pts and opponnent 0 pt
              current_mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 3;
              mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 0;
            } else {
              // both 1 pt
              current_mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 1;
              mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 1;
            }
          }
        });
        // get and set teams points_award values
      } else {
        // Set points_award to 0
        console.log("Value not defined!!!");
      }
    }
    // When marks change: set points_award to 3, 1 or 0
    marks = document.querySelectorAll("select[name*='[mark]']");
    marks.forEach(mark => mark.addEventListener('input', (event) => {
      updatePointsAward(event.target);
    }));

    // WHEN Schedule select is change : load new url for selected schedule
    schedule_select = document.querySelector("#schedule_id");
    const loadNewURL = (event) => {
      console.log(event.target.value);
      console.log(window.location.href);
      const url = "/power/results/"+event.target.value
      window.location.replace(url);
    }
    schedule_select.addEventListener('change', loadNewURL);
  }

  if (window.location.pathname === "/") {
    const activeSchedule = document.querySelector("#select-schedule > .active");
    if (activeSchedule) {
      activeSchedule.click();
    } else {
      // if last schedule is to far in past
      allSchedulesLinks = document.querySelectorAll("#select-schedule a");
      lastScheduleLink = allSchedulesLinks[allSchedulesLinks.length - 1];
      lastScheduleLink.classList.add("active");
      lastScheduleLink.click();
    }
  }

  showSelectSchedule();

});




