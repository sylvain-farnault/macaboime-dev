

const handleClickOnBtnShow = () => {
  const selectSchedule = document.querySelector("#select-schedule");
  if (selectSchedule) {
    console.log("pouet");
    selectSchedule.style.opacity ^= 1;
  }
}


const showSelectSchedule = () => {
  const btnShow = document.querySelector(".show-select-schedule");
  if (btnShow) {
    console.log("showSelectSchedule element selected");
    btnShow.addEventListener("click", handleClickOnBtnShow);
  }
}

export { showSelectSchedule }
