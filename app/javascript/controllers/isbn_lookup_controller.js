import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["isbnInput", "titleInput", "authorInput", "descriptionInput", "coverInput", "status"]

  connect() {
    this.debouncedFetch = this.debounce(this.fetchBookData.bind(this), 500)
  }

  isbnInputTargetConnected() {
    this.isbnInputTarget.addEventListener("input", this.debouncedFetch)
  }

  async fetchBookData() {
    const isbn = this.isbnInputTarget.value.trim()

    if (isbn.length < 10) return

    this.statusTarget.textContent = "Searching..."
    this.statusTarget.classList.add("loading")

    try {
      const response = await fetch(`/books/lookup?isbn=${encodeURIComponent(isbn)}`)

      if (!response.ok) {
        this.statusTarget.textContent = "Book not found"
        return
      }

      const data = await response.json()

      if (data.title && !this.titleInputTarget.value) {
        this.titleInputTarget.value = data.title
      }

      if (data.author && !this.authorInputTarget.value) {
        this.authorInputTarget.value = data.author
      }

      if (data.description && !this.descriptionInputTarget.value) {
        this.descriptionInputTarget.value = data.description
      }

      if (data.cover_url && this.hasCoverInputTarget) {
        this.coverInputTarget.value = data.cover_url
      }

      this.statusTarget.textContent = data.title ? "Book found!" : "Not found"
    } catch (error) {
      this.statusTarget.textContent = "Error searching"
    } finally {
      this.statusTarget.classList.remove("loading")
    }
  }

  debounce(fn, delay) {
    let timeout
    return (...args) => {
      clearTimeout(timeout)
      timeout = setTimeout(() => fn.apply(this, args), delay)
    }
  }
}