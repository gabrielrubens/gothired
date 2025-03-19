import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    if (typeof gtag === "function") {
      gtag("config", "G-TT8Q0QJ1PX", { page_path: window.location.pathname });
    }
  }
}