Time::DATE_FORMATS[:blog] = lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") }
Time::DATE_FORMATS[:leaderboard] = lambda { |time| time.strftime("%y.%m.%d %H:%M") }
Time::DATE_FORMATS[:date] = lambda { |time| time.strftime("%m/%d/%y") }
