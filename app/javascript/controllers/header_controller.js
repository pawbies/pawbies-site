import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header"
export default class extends Controller {
  static targets = [ "mobileNav" ];

  toggleMobileNav() {
    this.mobileNavTarget.classList.toggle("hidden");
  }
}
