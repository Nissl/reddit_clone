module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_time(time)
    time += Time.zone_offset('PST')
    time.strftime("on %-m/%d/%Y at %H:%M %p PST")  
    # TODO: fix with detected user timezone once authentication added
    # Right now, time forced to local timezone (PST)
    # See http://stackoverflow.com/questions/12326570/rails-how-to-get-the-current-users-time-zone-when-using-heroku
    # TODO: change month/date by detected user country
  end
end
