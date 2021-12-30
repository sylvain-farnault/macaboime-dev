// When marks change: set points_award to 3, 1 or 0
const updatePointsAward = (target) => {
  const current_mark = target;
  // console.log(current_mark);
  // console.log(typeof(target));
  // console.log('dddddddddddddddddddddddddddddd');
  if (current_mark.value) {
    // Get game_marks (the 2 opponents marks)
    const game_marks = current_mark.parentNode.parentNode.parentNode.querySelectorAll("input[name*='[mark]']");
    let statusSelect = null;
    game_marks.forEach(mark => {
      // If opponent_mark not null && mark is the opponent mark
      if (mark != current_mark && mark.value != "") {
        // Compare marks
        if (parseInt(mark.value) > parseInt(current_mark.value)) {
          // set opponnent 3 pts and current 0 pt
          mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 3;
          mark.parentNode.parentNode.querySelector("input[id*=_points_award").value = 3;
          current_mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 0;
          current_mark.parentNode.parentNode.querySelector("input[id*=_points_award").value = 0;
        } else if (parseInt(mark.value) < parseInt(current_mark.value)) {
          // set current 3 pts and opponnent 0 pt
          current_mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 3;
          current_mark.parentNode.parentNode.querySelector("input[id*=_points_award").value = 3;
          mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 0;
          mark.parentNode.parentNode.querySelector("input[id*=_points_award").value = 0;
        } else {
          // both 1 pt
          current_mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 1;
          current_mark.parentNode.parentNode.querySelector("input[id*=_points_award").value = 1;
          mark.parentNode.parentNode.querySelector("select[id*=_points_award").value = 1;
          mark.parentNode.parentNode.querySelector("input[id*=_points_award").value = 1;
        }
        statusSelect = mark.closest(".game-datas").querySelector("select[name*='[status]']");
        if (statusSelect) {
          statusSelect.value = 'played';
        }
      }
    });
    // get and set teams points_award values
  } else {
    // Set points_award to 0 ?
    console.log("Mark Value not defined!!!");
  }
}

const pointsAwardHandler = () => {
  const marks = document.querySelectorAll("input[name*='[mark]']");
  marks.forEach(mark => mark.addEventListener('input', (event) => {
    console.log("Mark just has been changed!")
    updatePointsAward(event.target);
  }));
}

export { updatePointsAward }
