import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Profile upload controller connected")
    this.setupValidation()
  }
  
  setupValidation() {
    const fileInput = document.getElementById("cv-upload")
    const submitBtn = document.getElementById("submit-btn")
    
    if (fileInput && submitBtn) {
      console.log("✅ Found file input and submit button")
      fileInput.addEventListener("change", () => {
        submitBtn.disabled = !fileInput.files.length
      })
    } else {
      console.warn("❌ Could not find file input or submit button")
    }
  }
}