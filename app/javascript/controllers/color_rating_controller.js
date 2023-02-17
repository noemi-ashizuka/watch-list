import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["rating"]

  connect() {
    this.ratingTargets.forEach((rating) => {
      if(rating.innerText >= 7) {
        rating.classList.add('green')
      } else if(rating.innerText >= 5) {
        rating.classList.add('orange')
      } else {
        rating.classList.add('red')
      }
    });
  }
}
