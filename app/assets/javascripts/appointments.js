document.addEventListener('turbolinks:load', function() {

  const authToken = document.querySelectorAll('head [name=csrf-token]')[0].content
  const monthAndYear = document.querySelector('.calendar-title'),
        monthsToNumbers = {
          January: 1,
          February: 2,
          March: 3, 
          April: 4,
          May: 5,
          June: 6,
          July: 7,
          August: 8,
          September: 9,
          October: 10,
          November: 11,
          December: 12
        },
        timeSlots = [ '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00' ];

  const updateURL = (currentURL, newURL) => history.replaceState(currentURL, null, newURL);

  //shalani's only working fridays, so we loop over these (wday-5)
  //current placeholder for a window of options that will pop up for the user to make an appt
  const getAvailability = (url, options) => {
    fetch(url, options)
    .then(response => response.json())
    .then(unavailableTimes => {
      const unavailableHours =  unavailableTimes.map(date=> date.match(/\d{2}:\d{2}/)[0]),
            availableTimes   =  timeSlots.filter(slot => !unavailableHours.includes(slot)),
            calendar         =  document.querySelector('.simple-calendar'),
            whiteBox         =  `<div class='whiteBox'>
                                  ${availableTimes.map(time => `<div>${time}</div>`).join('\n')}
                                </div>`

      calendar.innerHTML = whiteBox

      console.log('unavailable times are...', unavailableTimes)
      console.log('available times are..', availableTimes)
    });
  };

  const addAppointmentListeners = () => {
    document.querySelectorAll('.day.wday-5.future').forEach(friday => {
      friday.addEventListener('click', event => {
        friday.style.backgroundColor = 'red';

        const [month, year] = monthAndYear.innerText.split(' '),
              monthNum  = monthsToNumbers[month],
              day       = event.target.innerText,
              url       = `/appointments/get_availability?year=${year}&month=${monthNum}&day=${day}`,
              options = { 
                method: 'POST', 
                credentials: 'same-origin',
                headers: { 'X-CSRF-Token': authToken }
              };

        getAvailability(url, options)
      });
    });
  };

  const loadNewCalendar = (response, event) => {
    const newCalendar = response.body.querySelector('.simple-calendar'),
          oldCalendar = document.querySelector('.simple-calendar');

    oldCalendar.innerHTML = newCalendar.innerHTML;

    addAppointmentListeners();
    addNextPrevButtonListeners()
    updateURL(window.location.href, event.target.href);
  };

  const addNextPrevButtonListeners = () => {
    const nextAndPrevButtons = document.querySelectorAll('.calendar-heading a');
    nextAndPrevButtons.forEach(calendarLink => {
      calendarLink.addEventListener('click', event => {
        event.preventDefault()
        Rails.ajax({
          type: 'GET',
          url: event.target.href,
          success: response => loadNewCalendar(response, event)
        });
      })
    })
  };

  addNextPrevButtonListeners()
  addAppointmentListeners()
})