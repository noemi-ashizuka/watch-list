// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import { initAOS } from '../plugins/init_aos'
import { initSelect2 } from '../plugins/init_select2'
import { initStarRating } from '../plugins/init_star_rating';
import 'controllers';

Rails.start()
ActiveStorage.start()


document.addEventListener('turbo:load', () => {
  // Call your functions here, e.g:
  // console.log('turbo')
  initSelect2();
  initAOS();
  initStarRating();
});
