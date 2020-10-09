// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

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
    // change select style to be the same than selected option
    // ...?

    // When forfeit checkbox is changed to true: set mark values to 0 and 3
    checkboxes = document.querySelectorAll("input[id*='_forfeit']");
    const updateMarks = (event) => {
      console.log(event.target);
      const forfeit_mark = event.target.parentNode.parentNode.querySelector("select");
      console.log(forfeit_mark);
      if (event.target.checked == true) {
        forfeit_mark.parentNode.parentNode.parentNode.querySelectorAll("select[id*=_mark]").forEach(mark => {
          if (mark != forfeit_mark) {
            forfeit_mark.value = 0;
            mark.value = 3;
          }
        });
      }
      updatePointsAward(event);
    }
    checkboxes.forEach(checkbox => checkbox.addEventListener('change', updateMarks));

    // When marks change: set points_award to 3, 1 or 0
    marks = document.querySelectorAll("select[id*=_mark]");
    const updatePointsAward = (event) => {
      current_mark = event.target;
      if (current_mark.value) {
        console.log(current_mark);
        // Get opponent_mark
        marks = current_mark.parentNode.parentNode.parentNode.querySelectorAll("select[id*=_mark]");
        console.log(marks);
        marks.forEach(mark => {
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
    marks.forEach(mark => mark.addEventListener('input', updatePointsAward));
  }

});


// Forfeit ID schedule_games_attributes_0_results_attributes_0_forfeit
// Forfeit ID schedule_games_attributes_0_results_attributes_1_forfeit
// Mark ID schedule_games_attributes_0_results_attributes_0_mark
// Mark ID schedule_games_attributes_0_results_attributes_1_mark
//


