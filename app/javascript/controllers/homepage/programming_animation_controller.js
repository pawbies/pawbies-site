import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="homepage--programming-animation"
export default class extends Controller {
  static targets = [ "image" ];

  connect() {
    let index = 0;
    setInterval(() => {
      this.imageTargets.forEach((img, i) => {
        img.classList.toggle("opacity-100", i === index);
        img.classList.toggle("opacity-0", i !== index);
      });
      index = (index + 1) % this.imageTargets.length;
    }, 3000);
  }
}
