import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "themeToggle", "profileMenu"]

  connect() {
    // Check and set the initial theme mode based on user's preference or system settings
    this.initializeThemeMode()
  }

  toggleMenu() {
    // Toggle the visibility of the sidebar menu
    this.menuTarget.classList.toggle("hidden")
  }

  toggleDrawer() {
    // Logic to handle the drawer for mobile devices
    const drawer = document.getElementById('app-menu-drawer')
    if (drawer) {
      drawer.classList.toggle("hidden")
    }
  }

  toggleThemeMode() {
    // Toggle between dark mode and light mode
    document.documentElement.classList.toggle('dark')
    this.storeThemePreference()
  }

  initializeThemeMode() {
    // Initialize theme mode based on stored preference or system settings
    const prefersDarkScheme = window.matchMedia("(prefers-color-scheme: dark)").matches
    const storedTheme = localStorage.getItem('theme')

    if (storedTheme === 'dark' || (!storedTheme && prefersDarkScheme)) {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
  }

  storeThemePreference() {
    // Store the user's theme preference in localStorage
    if (document.documentElement.classList.contains('dark')) {
      localStorage.setItem('theme', 'dark')
    } else {
      localStorage.setItem('theme', 'light')
    }
  }

  toggleProfileMenu() {
    // Toggle the visibility of the profile dropdown menu
    this.profileMenuTarget.classList.toggle("hidden")
  }
}
