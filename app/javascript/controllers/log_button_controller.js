import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="log-button"
export default class extends Controller {



  connect() {
    const mealTitles = document.querySelectorAll('.meal');

    mealTitles.forEach((mealTitle) => {
      mealTitle.addEventListener('click', () => {
        const currentContent = mealTitle.nextElementSibling;

        // Alterna a classe no próprio conteúdo
        currentContent.classList.toggle('meal-display-none');
      });
    });

  }
}
