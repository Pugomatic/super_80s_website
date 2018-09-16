class LoadWorldsAndLevels < ActiveRecord::Migration[4.2]
  def change
    # CultureFormat.create! name: 'Other', enum_index: 0
    # CultureFormat.create! name: 'VHS', enum_index: 1
    # CultureFormat.create! name: 'Cassette', enum_index: 2
    # CultureFormat.create! name: 'Diskette', enum_index: 3
    # CultureFormat.create! name: 'Cartridge', enum_index: 4
    # CultureFormat.create! name: 'CD', enum_index: 5
    # CultureFormat.create! name: 'LaserDisc', enum_index: 6
    #
    toyland = World.create! title: "Wonder Years", position: 1, year: '1980'
    arcadia = World.create! title: "Arcadia", position: 2, year: '1981'
    miami = World.create! title: "Miami Nice", position: 3, year: '1982'
    streets = World.create! title: "Street Beatz", position: 4, year: '1983'
    horror = World.create! title: "Evil Dread", position: 5, year: '1984'


    level = horror.levels.create! name: 'Frite Nite', boss: true, number: 41, month: 8
    level = horror.levels.create! name: 'Boomstick', next_level: level, number: 40, month: 7

    level = horror.levels.create! name: 'House', next_level: level, number: 39, month: 6

    level = horror.levels.create! name: 'Blood Sport', next_level: level,  level_up_player: true, number: 38, month: 5

    level = horror.levels.create! name: 'Simply Dead', next_level: level, number: 37, month: 4

    level = horror.levels.create! name: 'Red Dawn', next_level: level, number: 36, month: 3

    level = horror.levels.create! name: 'Ghoulies & Gremlins', next_level: level, number: 35, month: 2

    level = horror.levels.create! name: 'Sematary Gates', next_level: level, level_up_player: true, number: 34, month: 1


    level = streets.levels.create! name: 'Escape from NYC', next_level: level, boss: true, number: 33, month: 8

    level = streets.levels.create! name: 'Toxic Revenger', next_level: level, number: 32, month: 7

    level = streets.levels.create! name: 'Silkwood Shower', next_level: level, number: 31, month: 6

    level = streets.levels.create! name: 'Radio Active', next_level: level, number: 30, month: 5

    level = streets.levels.create! name: 'Green Machine', next_level: level, level_up_player: true, number: 29, month: 4

    level = streets.levels.create! name: 'Going Underground', next_level: level, number: 28, month: 3

    level = streets.levels.create! name: 'Raise Da Roof', next_level: level, number: 27, month: 2

    level = streets.levels.create! name: 'Neon Streetz', next_level: level, number: 26, month: 1


    level = miami.levels.create! name: 'Chopper Commando', next_level: level, level_up_player: true, boss: true, number: 25, month: 8

    level = miami.levels.create! name: "Magnum's Opus", next_level: level, number: 24, month: 7

    level = miami.levels.create! name: 'Wallywood', next_level: level, number: 23, month: 6

    level = miami.levels.create! name: 'Tremorz', next_level: level, number: 22, month: 5

    level = miami.levels.create! name: 'White Lines', next_level: level, number: 21, month: 4

    level = miami.levels.create! name: 'Ocean Drive', next_level: level, number: 20, month: 3

    level = miami.levels.create! name: 'Tastee Wavez', next_level: level, number: 19, month: 2

    level = miami.levels.create! name: 'Miami Nice', next_level: level, level_up_player: true, number: 18, month: 1


    level = arcadia.levels.create! name: 'Space Ace', next_level: level, minigame: true, number: 17, month: 9

    level = arcadia.levels.create! name: 'Victory or Death', next_level: level, boss: true, number: 16, month: 8

    level = arcadia.levels.create! name: 'Pinball Whiz', next_level: level, number: 15, month: 7

    level = arcadia.levels.create! name: 'Quarter Flash', next_level: level, number: 14, month: 6

    level = arcadia.levels.create! name: 'Elevator Action', next_level: level, level_up_player: true, number: 13, month: 5

    level = arcadia.levels.create! name: 'War Games', next_level: level, number: 12, month: 4
    level = arcadia.levels.create! name: 'Wonkey Pong', next_level: level, number: 11, month: 3

    level = arcadia.levels.create! name: "Hogan's Run", next_level: level, number: 10, month: 2

    level = arcadia.levels.create! name: 'Arcadia', next_level: level, number: 9, month: 1

    level = toyland.levels.create! name: 'Hot Wheelz', next_level: level, boss: true, number: 8, month: 8

    level = toyland.levels.create! name: 'Nite Lite', next_level: level, number: 7, month: 7

    level = toyland.levels.create! name: 'Kids at Play', next_level: level, number: 6, month: 6

    level = toyland.levels.create! name: 'Legotron', next_level: level, number: 5, month: 5

    level = toyland.levels.create! name: "Pee Wee's Treehouse", next_level: level, level_up_player: true, number: 4, month: 4

    level = toyland.levels.create! name:  'Itchy & Sketchy', next_level: level, number: 3, month: 3

    level = toyland.levels.create! name:  'Simon Says', next_level: level, number: 2, month: 2

    toyland.levels.create! name: 'Super 80s World', next_level: level, number: 1, month: 1

    CultureFormat.create! name: 'Other', enum_index: 0
    vhs = CultureFormat.create! name: 'VHS', enum_index: 1
    cassette = CultureFormat.create! name: 'Cassette', enum_index: 2
    CultureFormat.create! name: 'Diskette', enum_index: 3
    cartridge = CultureFormat.create! name: 'Cartridge', enum_index: 4
    CultureFormat.create! name: 'CD', enum_index: 5
    CultureFormat.create! name: 'LaserDisc', enum_index: 6

    Achievement.create! name: 'SOLID GOLD',
                        sort_name: 'solid_gold',
                        match_type: Achievement::SOLID_GOLD,
                        description: "Collected all gold items for a single level",
                        matches_allowed: -1,
                        match_timeframe: Achievement::LEVEL

    Achievement.create! name: "The Golden Child",
                        sort_name: 'golden_child',
                        match_type: Achievement::SOLID_GOLD,
                        description: "Congratulations!  You saved the '80s collecting all gold items!",
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME

    %w(1980 1981 1982 1983 1984).each do |year|
      Achievement.create! name: "RESCUED #{year}!",
                          sort_name: "rescued_#{year}",
                          description: "You collected every gold item in #{year} and rescued the year!",
                          match_type: Achievement::SOLID_GOLD,
                          matches_allowed: 1,
                          match_timeframe: Achievement::YEAR,
                          match_year: year
    end

    Achievement.create! name: "EVERY SINGLE MOVIE!!!",
                        sort_name: "every_movie",
                        match_type: Achievement::ALL_ITEMS_FORMAT,
                        matches_allowed: 1,
                        description: 'Woah!  You collected every single movie in the game',
                        match_timeframe: Achievement::GAME,
                        match_format: vhs

    Achievement.create! name: "EVERY SINGLE ALBUM!!!",
                        sort_name: "every_album",
                        description: 'Way cool!  You collected every single album in the game',
                        match_type: Achievement::ALL_ITEMS_FORMAT,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_format: cassette

    Achievement.create! name: "EVERY SINGLE GAME!!!",
                        sort_name: "every_game",
                        description: 'You collected every single video game in Super 80s World',
                        match_type: Achievement::ALL_ITEMS_FORMAT,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_format: cartridge


    %w(1980 1981 1982 1983 1984).each do |year|
      Achievement.create! name: "ALL MOVIES #{year}",
                          sort_name: "every_movie_#{year}",
                          description: "Sweet!  You collected every movie from #{year}.",
                          match_type: Achievement::ALL_ITEMS_FORMAT,
                          matches_allowed: 1,
                          match_timeframe: Achievement::YEAR,
                          match_year: year,
                          match_format: vhs

      Achievement.create! name: "ALL ALBUMS #{year}",
                          sort_name: "every_album_#{year}",
                          description: "You Rock!  You have every album from #{year}.",
                          match_type: Achievement::ALL_ITEMS_FORMAT,
                          matches_allowed: 1,
                          match_timeframe: Achievement::YEAR,
                          match_year: year,
                          match_format: cassette

      Achievement.create! name: "ALL GAMES #{year}",
                          sort_name: "every_game_#{year}",
                          description: "Way to go!  Every game from #{year} has been collected.",
                          match_type: Achievement::ALL_ITEMS_FORMAT,
                          matches_allowed: 1,
                          match_timeframe: Achievement::YEAR,
                          match_year: year,
                          match_format: cartridge
    end

    %w(1980 1981 1982 1983 1984).each do |year|
      Achievement.create! name: "COMPLETE TOTAL #{year}",
                          sort_name: "every_thing_#{year}",
                          description: "Totally awesome! You now have every item from #{year}!",
                          match_type: Achievement::ALL_ITEMS_TOTAL,
                          matches_allowed: 1,
                          match_timeframe: Achievement::YEAR,
                          match_year: year
    end

    Achievement.create! name: "ALL THE THINGS!",
                        sort_name: 'every_thing',
                        description: 'Ultimate 80s hoarder: You collected everything in the game!',
                        match_type: Achievement::ALL_ITEMS_TOTAL,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME


    Achievement.create! name: "Tape Head",
                        sort_name: 'tape_head',
                        description: "Press eject!  You've collected over 150 cassettes.",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 150,
                        match_format: cassette

    Achievement.create! name: "Eight Tracker",
                        sort_name: 'eight_tracker',
                        description: "Nice!  You collected 8 albums in one level!",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::LEVEL,
                        match_count: 8,
                        match_format: cassette

    Achievement.create! name: "Dual Cassette Doc",
                        sort_name: 'dual_cassette',
                        description: "Super duper!  You've collected over 200 cassettes.",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 200,
                        match_format: cassette

    Achievement.create! name: "Movie Phoney",
                        sort_name: 'beta_max',
                        description: "You collected over 10 movies in a single level!",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::LEVEL,
                        match_count: 10,
                        match_format: vhs

    Achievement.create! name: "Vertical Hold",
                        sort_name: 'vertical_hold',
                        description: "You collected over 200 movies overall!",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 200,
                        match_format: vhs


    Achievement.create! name: "Kind Winder",
                        sort_name: 'kind_winder',
                        description: "You collected over 100 movies overall!",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 100,
                        match_format: vhs

    Achievement.create! name: "Writeous Protection",
                        sort_name: 'write_protect',
                        description: "You duped over six video games in a single level.",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::LEVEL,
                        match_count: 7,
                        match_format: cartridge


    Achievement.create! name: "Studio 54",
                        sort_name: 'studio_54',
                        description: "Do a little dance...  you now have over 54 items!",
                        match_type: Achievement::TOTAL_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 54

    Achievement.create! name: "The Bandwagon",
                        sort_name: 'bandwagon',
                        description: "You're catching on - collecting over 30 albums",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 30,
                        match_format: cassette

    Achievement.create! name: "99 Red Cassettes",
                        sort_name: '99_red',
                        description: "You've collected over 99 albums so far!",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 99,
                        match_format: cassette

    Achievement.create! name: "Fair Weather Fan",
                        sort_name: 'fair_weather_fan',
                        description: "You have over a dozen albums in your collection",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 12,
                        match_format: cassette


    Achievement.create! name: "Sixteen Candles",
                        sort_name: 'sixteen_candles',
                        description: "You have added 16 movies to your collection",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 16,
                        match_format: vhs

    Achievement.create! name: "Funderdome",
                        sort_name: 'beyond_funderdome',
                        description: "You collected over 20 video games.",
                        match_type: Achievement::FORMAT_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 20,
                        match_format: cartridge

    Achievement.create! name: "The Goose",
                        sort_name: 'goose',
                        description: "Wow.  You managed to collect absolutely nothing.",
                        match_type: Achievement::TOTAL_COUNT_EXACT,
                        matches_allowed: 1,
                        match_timeframe: Achievement::LEVEL,
                        match_count: 0

    Achievement.create! name: "The Hitcher",
                        sort_name: 'hitcher',
                        description: "You find meaning in collecting exactly 42 items.",
                        match_type: Achievement::TOTAL_COUNT_EXACT,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 42

    Achievement.create! name: "1-Hit Wanderer",
                        sort_name: '1_hit',
                        description: "Your 15 minutes of fame - collecting 7 of the decade's 1-hit wonders.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 7

    Achievement.create! name: "Atari Thumb",
                        sort_name: 'atari_thumb',
                        description: "Old school.  Your collection has over 10 Atari titles.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 10

    Achievement.create! name: "Rapper's Delight",
                        sort_name: 'rappers_delight',
                        description: "Dope. You collected a bunch of old-school hip hop tapes.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Album Artist",
                        sort_name: 'album_art',
                        description: "A collection of the coolest albums covers from the era.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 4

    Achievement.create! name: "Durany-boy",
                        sort_name: 'durany_boy',
                        description: "Three Duran Duran cassettes... and an issue of Teen Beat",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: "Techno Popper",
                        sort_name: 'techno_popper',
                        description: "You just can't get enough of these techno pop classics!",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 6

    Achievement.create! name: "The Industry",
                        sort_name: 'industry',
                        description: "Welcome to the machine, containing 6 industrial tapes.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 6

    Achievement.create! name: "New Wave Dave",
                        sort_name: 'new_wave_dave',
                        description: "You caught the wave with these new albums.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 6

    Achievement.create! name: "Six Degrees",
                        sort_name: 'six_degrees',
                        description: "You now own several Kevin Bacon movies!",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: "The Hoff",
                        sort_name: 'hoff',
                        description: "Don't hassle this collection... or the Hoff",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: "So Lo",
                        sort_name: 'so_lo',
                        description: "You now own five albums by solo artists",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Dressed in Black",
                        sort_name: 'dressed_in_black',
                        description: "Put on the mascara, and listen to your goth album collection",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Simply the Best",
                        sort_name: 'simply_the_best',
                        description: "You own at least 10 of the best albums of the '80s!",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 10

    Achievement.create! name: "Five-O",
                        sort_name: 'five_o',
                        description: "You now own a pair of 'buddy-cop' movies",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 2

    Achievement.create! name: "Hairmetal Monster",
                        sort_name: 'hairmetal',
                        description: "Sweet! You now own over 8 hair-metal albums",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 8


    Achievement.create! name: "Carpenter's Assistant",
                        sort_name: 'carpenter',
                        description: "You've collected all of John Carpenter's masterpieces.",
                        match_type: Achievement::MULTI_ITEM_EXACT,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5


    Achievement.create! name: "Italian Stallion",
                        sort_name: 'italian',
                        description: "Yo adrian! We now have over 5 movies featuring a Stallone.",
                        match_type: Achievement::MULTI_ITEM_EXACT,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Montage Rock",
                        sort_name: 'montage',
                        description: "Let the training montage begin.  You now have the music for it.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3


    Achievement.create! name: "John Hughes Hi-5",
                        sort_name: 'john_hughes',
                        description: "You now own 5 movies written or directed by the master himself.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Two a T",
                        sort_name: 'two_of_a_t',
                        description: "Two shows starring Mr. T have been added to your collection.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Stranger Kings",
                        sort_name: 'stranger_kings',
                        description: "Several Stephen King movies have been added to your collection.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Metalhead",
                        sort_name: 'metalhead',
                        description: "Rock on!  You now own 7 heavy metal albums  \\m/",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 7


    Achievement.create! name: "Pop Music Idols",
                        sort_name: 'pop_music',
                        description: "You now have 5 albums by pop music idols of the 80s.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Post-punk Pilot",
                        sort_name: 'post_punk',
                        description: "Your collection now contains 5 or more post-punk classics.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Mosh Pitter",
                        sort_name: 'mosh',
                        description: "You have collected 7 or more punk albums.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 7

    Achievement.create! name: "Hardcore Hero",
                        sort_name: 'hardcore',
                        description: "You have 5 or more albums from hardcore heavyweights.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "The Stache",
                        sort_name: 'stache',
                        description: "Your collection is ready for Movember with a strong showing of 80s mustaches.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Whiplash Smile",
                        sort_name: 'whiplash',
                        description: "You collected 3 or more albums featuring Billy Idol.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: "Couch Potato",
                        sort_name: 'couch_potato',
                        description: "You have a dozen seasons of TV shows.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 12

    Achievement.create! name: "The Govenator",
                        sort_name: 'govenator',
                        description: "Your collection now contains several early Arnie movies.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: "Blockbusters",
                        sort_name: 'blockbuster',
                        description: "You own 5 of the top-grossing movies from the 1980s.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Soundtrekker",
                        sort_name: 'soundtrekker',
                        description: "You are building your collection of cool soundtracks.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: "Action Jackson",
                        sort_name: 'action',
                        description: "At least 6 action movies have been added to your collection.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 6

    Achievement.create! name: "Horror Master",
                        sort_name: 'horror',
                        description: "At least 6 horror movies have been added to your collection.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 6

    Achievement.create! name: "Cold War Commando",
                        sort_name: 'cold_war',
                        description: "Nice work comrade, you now have several cold war movies.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: "Teacher's Pet",
                        sort_name: 'teachers_pet',
                        description: "You've collected 5 teen movies from the decade.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: "Funny Bone",
                        sort_name: 'funny_bone',
                        description: "You've collected 8 comedies from the 80s.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 8

    Achievement.create! name: "SaxMaster Solo",
                        sort_name: 'saxmaster_solo',
                        description: "Three albums with sultry saxophone solos.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: 'Part Deux',
                        sort_name: 'part_deux',
                        description: "A solid collection of movie sequels.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: 'Sitcom-a-rama',
                        sort_name: 'sitcom_o_rama',
                        description: "Seven seasons of '80s sitcoms.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 7

    Achievement.create! name: 'Brat Pack Sack',
                        sort_name: 'brat_pack',
                        description: "A six pack of movies featuring members of the brat pack.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 6

    Achievement.create! name: 'Glass Joe',
                        sort_name: 'glass_joe',
                        description: "Three or more fighting games / movies collected.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: 'LA Stories',
                        sort_name: 'la_stories',
                        description: "Four movies set in L.A.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 4

    Achievement.create! name: 'Escape from NY',
                        sort_name: 'escape_from_ny',
                        description: "Six movies set in NYC.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 6

    Achievement.create! name: 'Muppet Manor',
                        sort_name: 'muppet_manor',
                        description: "Three muppet movies were added to your collection.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: 'Space Ace',
                        sort_name: 'space_ace',
                        description: "A stellar collection of space games.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: 'Frequent Flyer',
                        sort_name: 'frequent_flyer',
                        description: "You clearly feel the need for speed with these flying games.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: 'Speed Racer',
                        sort_name: 'speed_racer',
                        description: "A rad collection of racing games.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: 'Sporty Spice',
                        sort_name: 'sporty_spice',
                        description: "A sweet collection of sports games.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: 'Double Jump',
                        sort_name: 'double_jump',
                        description: "A half dozen early platformer games.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 6

    Achievement.create! name: 'Area 51',
                        sort_name: 'area_51',
                        description: "They're here - your collection of UFO movies.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 3

    Achievement.create! name: 'Debut Debut',
                        sort_name: 'debut',
                        description: "You've collected several debut albums.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: 'Only in the 80s',
                        sort_name: 'only_80s',
                        description: "Some shows you'd only find in the '80s.",
                        match_type: Achievement::MULTI_ITEM_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 5

    Achievement.create! name: 'Zero to Hero',
                        sort_name: 'zero_to_hero',
                        description: "Drop that zero - you're the hero! You collected your first item.",
                        match_type: Achievement::TOTAL_COUNT_MINIMUM,
                        matches_allowed: 1,
                        match_timeframe: Achievement::GAME,
                        match_count: 1


    require 'rake'
    Rake::Task['data:import'].invoke
    Rake::Task['data:stats'].invoke
  end
end
