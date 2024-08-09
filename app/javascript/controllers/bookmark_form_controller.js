import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form"]
  connect() {
    console.log("connected");
  }

  reveal(event) {
    // console.log(event.currentTarget);
    this.formTarget.classList.toggle("d-none")
    console.log(this.formTarget);
    
  }
}
