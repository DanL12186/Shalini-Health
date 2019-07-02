module TimeConversion
  
    #converts a 9-5 day in standard time to military or vice versa;
    #returns military time as a number, standard time as a string w/AM or PM
    #pass in 'standard' (or anything) to convert from military to standard
    def convert_hour(hour, convert_to = 'military')    
      if convert_to == 'military'
        hour < 9 ? (hour + 12) : (hour)
      else
        return '12:00 (noon)' if hour == 12
        hour < 12 ? "#{hour}:00 AM" : "#{hour - 12}:00 PM"
      end
    end
   
    #formats, e.g., '3/09/2019 16:00' => 'Tuesday March 9th, 2019 at 4 PM'
    def format_date(date)
      year, month, day, day_name, hour = [
        date.year,
        Date::MONTHNAMES[date.month],
        date.day.ordinalize,
        date.strftime("%A"),
        convert_hour(date.hour, 'standard')
      ]

      "#{day_name} #{month} #{day}, #{year} at #{hour}"
    end
end