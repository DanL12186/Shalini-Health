document.addEventListener('turbolinks:load', function() {
  const authToken = document.querySelectorAll('head [name=csrf-token]')[0].content;

  const modal           = document.getElementById("myModal"),
        monthAndYear    = document.querySelector('.calendar-title'),
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
        timeSlots = [
          '09:00',
          '10:00',
          '11:00',
          '12:00',
          '13:00',
          '14:00',
          '15:00',
          '16:00',
          '17:00'
        ];

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target === modal) {
        
        //clear modal
        document.querySelector('.modal-content').innerHTML = ''
        modal.style.display = "none";
      }
    }

  const updateURL = (currentURL, newURL) => history.replaceState(currentURL, null, newURL);

  const militaryToStandardTime = time => {
    if (time === '12:00') {
      return '12:00 pm (noon)'
    } else if (time < '12:00') {
      return `${time.replace(/^0/,'')} am`
    } else {
      return `${parseInt(time) - 12}:00 pm`
    }
  }

  //current placeholder for a window of options that will pop up for the user to make an appt
  const getAvailability = (url, options, month, day, year) => {
    fetch(url, options)
    .then(response => response.json())
    .then(unavailableTimes => {
      const unavailableHours =  unavailableTimes.map(date=> date.match(/\d{2}:\d{2}/)[0]),
            availableTimes   =  timeSlots.filter(slot => !unavailableHours.includes(slot)),
            standardTimes    =  availableTimes.map(time => militaryToStandardTime(time)),
            modalContent     =  document.querySelector('.modal-content');

      const createRadioButton = time => `<input type="radio" id="${time}" name="timeSelect" value="${time}">
                                        <label for="${time}">${time}</label>`;

      modalContent.innerHTML = `<span class="close">&times;</span>
                                <h2 class='date-title'> Available Times for Friday, ${month} ${day}, ${year}: </h2>
                                <form class='selectAppointment'>
                                  <div id='options'></div>
                                </form>`

      const form = document.querySelector('.selectAppointment')
      
      standardTimes.forEach(time => {
        form.innerHTML += `<p> ${createRadioButton(time, time)} </p>`
      });

      form.innerHTML += `<button input='submit'>Submit</button>`
      document.querySelectorAll('.close').forEach(thing=> {
        thing.addEventListener('click', function() {
          modal.style.display = "none";
        })
      });
    });
  };
  
  //shalani's only working fridays, so we only loop over these (wday-5)
  const addCalendarListeners = () => {
    const availableDays = document.querySelectorAll('.day.wday-5.future')
    availableDays.forEach(friday => {
      friday.addEventListener('click', event => {
        friday.style.backgroundColor = 'red';
        modal.style.display = "block";

        const [month, year] = monthAndYear.innerText.split(' '),
              monthNum      = monthsToNumbers[month],
              day           = event.target.innerText,
              url           = `/appointments/get_availability?year=${year}&month=${monthNum}&day=${day}`,
              options       = { 
                                method: 'POST', 
                                credentials: 'same-origin',
                                headers: { 'X-CSRF-Token': authToken }
                              };

        getAvailability(url, options, month, day, year)
      });
    });
  };

  const loadNewCalendar = (response, event) => {
    const oldCalendar = document.querySelector('.simple-calendar'),
          newCalendar = response.body.querySelector('.simple-calendar');

    oldCalendar.innerHTML = newCalendar.innerHTML;

    addCalendarListeners();
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
  addCalendarListeners()
})