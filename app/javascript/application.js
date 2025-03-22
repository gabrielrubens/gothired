// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
import setupCVUploadValidation from "controllers/profile_upload_controller"

import "@hotwired/turbo-rails"
import "trix"
import "@rails/actiontext"
import * as bootstrap from "bootstrap"

document.addEventListener("DOMContentLoaded", setupCVUploadValidation);