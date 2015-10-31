Time::DATE_FORMATS[:blog] = lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") }

