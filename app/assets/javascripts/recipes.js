// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener('turbolinks:load', () => {

  const hideHeaderAndFooter = () => {
    document.querySelector('.bg-head').classList.add('hide')
    document.querySelector('.bg-foot').classList.add('hide')
  }

  const showHeaderAndFooter = () => {
    document.querySelector('.bg-head').classList.remove('hide')
    document.querySelector('.bg-foot').classList.remove('hide')
  }

  if (document.querySelector("#recipe-page")) {
    if (window.innerWidth <= 1000) {
      hideHeaderAndFooter()
    }
    window.addEventListener('resize', () => {
      if (window.innerWidth <= 1000) {
        hideHeaderAndFooter()
      } else {
        showHeaderAndFooter()
      }
    }) 
  }
})