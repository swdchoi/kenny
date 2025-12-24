import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="paymentterms"
export default class extends Controller {
  static targets = ["percentage", "amount", "total", "milestone", "manual"]
  connect() {
  }

  calculateFromPercentage () {
    const percentage = parseFloat(this.percentageTarget.value)
    const total = parseFloat(this.totalTarget.innerText)

    if (isNaN(percentage) || isNaN(total)) return

    const amount = (total * percentage) / 100
    this.amountTarget.value = amount.toFixed(2)
  }

  calculateFromAmount() {
    const amount = parseFloat(this.amountTarget.value)
    const total = parseFloat(this.totalTarget.innerText)

    if (isNaN(amount) || isNaN(total) || total === 0) return

    const percentage = (amount / total) * 100
    this.percentageTarget.value = percentage.toFixed(2)
  }

   switch(event) {
    const mode = event.target.value

    this.milestoneTarget.classList.toggle("d-none", mode !== "milestone")
    this.manualTarget.classList.toggle("d-none", mode !== "manual")
  }

}
