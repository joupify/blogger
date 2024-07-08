import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "parentForm"];

  connect() {
    console.log("Hello from reply!");
  }

  toggle(event) {
    event.preventDefault();
    console.log("Toggle function called!");

    const form = this.formTarget;
      form.style.display = form.style.display === "none" ? "block" : "none";
    
  }

  reset(event) {
    event.preventDefault();
    console.log("reset function called!");

    const form = event.target.closest("form");
    if (form) {
      form.reset();
      const formContainer = form.closest("[data-reply-target='form']");
      if (formContainer) {
        formContainer.style.display = "none"; // Hide the reply form
      }
    }
  }
}

