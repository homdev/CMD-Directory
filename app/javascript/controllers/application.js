import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
import EvaluationController from "./evaluation_controller";

// Initialisation de l'application Stimulus
const application = Application.start();
application.debug = false;
window.Stimulus = application;

// Charger les contrôleurs automatiquement
eagerLoadControllersFrom("controllers", application);

// Enregistrer le contrôleur d'évaluation
application.register("evaluation", EvaluationController);

document.addEventListener("DOMContentLoaded", function() {
  // Gestion du menu mobile
  const burger = document.getElementById('burger');
  const mobileMenu = document.getElementById('mobile-menu');
  
  if (burger && mobileMenu) {
    burger.addEventListener('click', function () {
      mobileMenu.classList.toggle('hidden');
    });
  }

  // Prévisualisation de l'image de profil
  const profileImageInput = document.getElementById('user_profile_image');
  const profileImagePreview = document.querySelector('.profile-image');
  
  if (profileImageInput && profileImagePreview) {
    profileImageInput.addEventListener('change', function () {
      const file = this.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          profileImagePreview.src = e.target.result;
          console.log("Profile image updated in preview.");
        }
        reader.readAsDataURL(file);
      }
    });
  }

  // Prévisualisation de l'image de bannière
  const bannerImageInput = document.querySelector('input[name="user[banner_image]"]');
  const bannerImagePreview = document.querySelector('.banner-image');
  
  if (bannerImageInput && bannerImagePreview) {
    bannerImageInput.addEventListener('change', function () {
      const file = this.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          bannerImagePreview.src = e.target.result;
          console.log("Banner image updated in preview.");
        }
        reader.readAsDataURL(file);
      }
    });
  }
});

export { application };
