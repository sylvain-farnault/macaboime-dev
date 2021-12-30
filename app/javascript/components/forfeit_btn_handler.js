import { updatePointsAward } from './points_award_handler'

// When forfeit checkbox is changed to true: set mark values to 0 and 3
const updateMarksOnForfeit = (event) => {
  console.log(event.target);
  const forfeit_mark = event.target.parentNode.parentNode.querySelector("input[name*='[mark]']");
  // console.log(forfeit_mark);
  if (event.target.checked == true) {
    // debugger;
    forfeit_mark.parentNode.parentNode.parentNode.querySelectorAll("input[name*='[mark]']").forEach(mark => {
      if (mark != forfeit_mark) {
        forfeit_mark.value = 0;
        mark.value = 3;
        mark.parentNode.parentNode.querySelector("input[id*='_forfeit']").checked = false;
        updatePointsAward(mark);
      }
    });
  }
}

const forfeitBtnHandler = () => {
  const forfeit_checkboxes = document.querySelectorAll("input[id*='_forfeit']");
  forfeit_checkboxes.forEach(checkbox => checkbox.addEventListener('change', updateMarksOnForfeit));
}

export { forfeitBtnHandler }
