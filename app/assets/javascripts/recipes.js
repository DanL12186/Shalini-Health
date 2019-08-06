// All this logic will automatically be available in application.js.
document.addEventListener('turbolinks:load', () => {

  const hideOrShowHeaderAndFooter = hideOrShow => {
    if (hideOrShow === 'hide') {
      document.querySelector('.bg-head').classList.add('hide')
      document.querySelector('.bg-foot').classList.add('hide')
    } else {
      document.querySelector('.bg-head').classList.remove('hide')
      document.querySelector('.bg-foot').classList.remove('hide')
    }
  }

  //hide/show the footer and header if screen width crosses 1000px threshold
  const widthListener = () => {
    if (window.innerWidth <= 1000) {
      hideOrShowHeaderAndFooter('hide')
    } else {
      hideOrShowHeaderAndFooter('show')
    }
  }

  //execute only on recipe pages
  //immediately hide header/footer if page <= 1000 px, and listen for resizing
  if (document.querySelector("#recipe-page")) {
    if (window.innerWidth <= 1000) {
      hideOrShowHeaderAndFooter('hide')
    }

    window.addEventListener('resize', widthListener)

    //remove event listener upon leaving the page
    document.addEventListener('turbolinks:before-visit', function() {
      window.removeEventListener('resize', widthListener);
    })

  }
})

