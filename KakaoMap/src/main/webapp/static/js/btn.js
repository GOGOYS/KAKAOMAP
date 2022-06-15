var btn_food = document.querySelector("button#keyword1");
var btn_lodgment = document.querySelector("button#keyword2");

btn_food.addEventListener("click", () => {
  btn_food.classList.add("click");
  btn_lodgment.classList.remove("click");
});
btn_lodgment.addEventListener("click", () => {
  btn_lodgment.classList.add("click");
  btn_food.classList.remove("click");
});
