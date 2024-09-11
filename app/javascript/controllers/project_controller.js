// app/javascript/controllers/project_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  toggleForm(event) {
    event.preventDefault();
    const modal = document.getElementById("add-member-modal");
    modal.classList.toggle("hidden");
  }
}
