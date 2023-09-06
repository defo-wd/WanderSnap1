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


//画像プレビュー系のJava

  function previewImage() {
    const target = this.event.target;
    const file = target.files[0];
    const reader  = new FileReader();
    reader.onloadend = function () {
        const preview = document.querySelector("#preview")
        if(preview) {
            preview.src = reader.result;
        }
    }
    if (file) {
        reader.readAsDataURL(file);
    }
  }