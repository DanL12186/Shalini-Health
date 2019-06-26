document.addEventListener('turbolinks:load', function() {
  const authToken = document.querySelectorAll('head meta')[1].content
  
  //String as "Month Year", e.g. "June 2019"
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
        timeSlots = [ '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00' ]
            
  //shalani's only working fridays, so we loop over these (wday-5)
  document.querySelectorAll('.day.wday-5.future').forEach(function(friday) {
    friday.addEventListener('click', function() {
      friday.style.backgroundColor = 'red';

      const [month, year] = monthAndYear.innerText.split(' '),
            monthNum  = monthsToNumbers[month],
            day       = this.innerText,
            url       = `/appointments/get_availability?year=${year}&month=${monthNum}&day=${day}`,
            options = { 
              method: 'POST', 
              credentials: 'same-origin',
              headers: { 'X-CSRF-Token': authToken }
            };

      fetch(url, options)
        .then(response => response.json())
        .then(unavailableTimes => {
          const unavailableHours = unavailableTimes.map(date=> date.match(/\d{2}:\d{2}/)[0]),
                availableTimes   = timeSlots.filter(slot => !unavailableHours.includes(slot))

          console.log('unavailable times are...', unavailableTimes)
          console.log('available times are..', availableTimes)
      });
    });
  });

})