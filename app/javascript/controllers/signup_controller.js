// app/javascript/controllers/signup_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleSubmit(event) {
    const frame = this.element.closest("turbo-frame")
    
    // Google Analytics event tracking
    if (typeof gtag === 'function') {
      gtag('event', 'beta_signup', {
        'event_category': 'engagement',
        'event_label': 'beta signup form'
      });
    }
  }
}