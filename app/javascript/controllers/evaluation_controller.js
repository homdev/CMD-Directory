import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  connect() {
    console.log("Evaluation controller connected"); // Vérification que le contrôleur est bien connecté
  }

  // Basculer l'affichage du modal d'ajout/édition d'évaluation
  toggleForm(event) {
    console.log("toggleForm triggered"); // Vérification que le toggleForm est bien appelé
    event.preventDefault();
    const modal = document.getElementById("add-evaluation-modal");
    if (modal) {
      modal.classList.toggle("hidden"); // Affiche ou cache le modal
      console.log("Modal toggled"); // Log après l'affichage ou la fermeture du modal
    } else {
      console.error("Le modal d'évaluation n'a pas été trouvé.");
    }
  }

  // Fermer le modal après une soumission réussie
  closeModal() {
    console.log("closeModal called"); // Vérification que closeModal est bien appelé
    const modal = document.getElementById("add-evaluation-modal");
    if (modal) {
      modal.classList.add("hidden"); // Masque le modal après soumission
      console.log("Modal closed"); // Log après la fermeture du modal
    }
  }

  // Gérer la soumission d'une évaluation (après une réponse réussie)
  handleSubmit(event) {
    console.log("handleSubmit triggered", event); // Log pour voir si handleSubmit est appelé et les détails de l'événement
    if (event.detail.success) {
      console.log("Submission success", event.detail); // Log pour la réussite de la soumission
      this.closeModal(); // Fermer le modal
      this.formTarget.reset(); // Réinitialiser le formulaire
      console.log("Form reset and modal closed");
    } else {
      console.log("Submission failed", event.detail); // Log en cas d'échec de la soumission
    }
  }

  // Supprimer une évaluation via une requête asynchrone
  delete(event) {
    console.log("delete triggered"); // Vérification que la fonction delete est appelée
    event.preventDefault();
    const evaluationId = event.currentTarget.dataset.id; // Récupère l'ID de l'évaluation
    console.log("Evaluation ID to delete:", evaluationId); // Log de l'ID de l'évaluation à supprimer

    fetch(`/evaluations/${evaluationId}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Content-Type': 'application/json',
      },
    })
    .then(response => {
      if (response.ok) {
        console.log("Delete successful"); // Log pour la réussite de la suppression
        const element = document.getElementById(`evaluation_${evaluationId}`);
        if (element) {
          element.remove();  // Supprime l'évaluation du DOM
          console.log(`Évaluation ${evaluationId} supprimée avec succès.`);
        }
      } else {
        console.error("Échec de la suppression de l'évaluation");
        this.displayError("La suppression de l'évaluation a échoué.");
      }
    })
    .catch(error => {
      console.error("Erreur lors de la requête de suppression :", error);
      this.displayError("Une erreur est survenue lors de la suppression.");
    });
  }

  // Affiche un message d'erreur temporaire dans la liste des évaluations
  displayError(message) {
    console.log("Displaying error message:", message); // Log pour l'affichage des erreurs
    const errorDiv = document.createElement("div");
    errorDiv.className = "bg-red-500 text-white p-4 rounded-lg mb-4";
    errorDiv.innerText = message;

    const evaluationList = document.getElementById("evaluation-list");
    if (evaluationList) {
      evaluationList.prepend(errorDiv); // Affiche l'erreur en haut de la liste
      console.log("Error message displayed in evaluation list");

      setTimeout(() => {
        errorDiv.remove();  // Supprime l'erreur après 5 secondes
        console.log("Error message removed after timeout");
      }, 5000);
    } else {
      console.error("La liste des évaluations n'a pas été trouvée pour afficher l'erreur.");
    }
  }
}
