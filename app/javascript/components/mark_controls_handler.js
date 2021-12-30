import { updatePointsAward } from './points_award_handler'

const calculNewValue = (event) => {
  console.log(event.target);
  const markInput = event.target.parentElement.parentElement.querySelector("input");
  if (markInput) {
    const oldMark = markInput.value
    let newMark = eval(oldMark + event.target.dataset.step);
    if (newMark == -1) {
      newMark = 0
    }
    markInput.value = newMark;
    updatePointsAward(markInput);
  }
}

const markControlsHandler = () => {
  const markControls = document.querySelectorAll(".mark-controls i[data-step]");
  markControls.forEach( control => {
    const step = control.dataset.step;
    console.log(step);
    control.addEventListener("click", calculNewValue);
  });
}

export { markControlsHandler }
