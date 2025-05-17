// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()



document.addEventListener("turbolinks:load", function () {
  const showBtn = document.getElementById("show-more-comments");
  const hideBtn = document.getElementById("hide-comments");
  const hiddenComments = document.querySelectorAll(".comment-entry.d-none");

  if (showBtn && hideBtn) {
    showBtn.addEventListener("click", function () {
      hiddenComments.forEach(el => el.classList.remove("d-none"));
      showBtn.classList.add("d-none");
      hideBtn.classList.remove("d-none");
    });

    hideBtn.addEventListener("click", function () {
      hiddenComments.forEach(el => el.classList.add("d-none"));
      hideBtn.classList.add("d-none");
      showBtn.classList.remove("d-none");
    });
  }
});