import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button', 'stars']
  
  reset() {
    this.starsTarget.querySelector('.br-current-rating').innerText = ''
    this.starsTarget.querySelectorAll('.br-widget a').forEach((star) => {
      star.classList.remove('br-current')
      star.classList.remove('br-selected')
    })
    this.element.reset()
    this.buttonTarget.disabled = false
  }
}
