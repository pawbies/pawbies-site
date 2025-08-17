import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = [ "sidebar", "openButton" ];

  close() {
    this.sidebarTarget.classList.add("hidden");
    this.openButtonTarget.classList.remove("hidden");
  }

  open() {
    this.sidebarTarget.classList.remove("hidden");
    this.openButtonTarget.classList.add("hidden");
  }
}
