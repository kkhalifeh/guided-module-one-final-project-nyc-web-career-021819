# `class BeerBud`

#defining global variables

$user_input_from_favorite_beers = nil
$user_main_menu_input = nil


def welcome
  puts "Welcome to BeerBud!"
  sleep(1)
end

def get_username
  puts "Please enter your user name"
  gets.chomp.downcase
  sleep(1)
end

def main_menu
  puts "Welcome back! What would you like to do?"
  sleep(1)
  puts "1. View my favorites"
  puts "2. Access beer preferences"
  puts "3. Discover new beers"
  puts "4. Close program and drink"
  $user_main_menu_input = gets.chomp.to_i
end

def favorite_beers
  #pull data from join_table :favorites, puts beer.name from array []
  #limit to 8 selections
  #below where it says puts, pull data
  puts "Your favorites list:"
  puts "Use 0-9 to make your selection"
  puts "(0)  Beer A" #favorites_by_user[0]
  puts "(1)  Beer B"
  puts "(2)  Beer C"
  puts "(3)  Beer D"
  puts "(4)  Beer E"
  puts "(5)  Beer F"
  puts "(6)  Beer G"
  puts "(7)  Beer H"
  puts "(8)  Beer I"
  puts "(9)  Return to main menu"
  puts $user_input_from_favorite_beers
  $user_input_from_favorite_beers = gets.chomp.to_i
  puts $user_input_from_favorite_beers
    if $user_input_from_favorite_beers == 9
      main_menu
    else
      puts "CURRENT BEER SELECTION #{$user_input_from_selected_beer}" #code should take user_input_from_favorite_beers and display beername dynamically
      selected_beer_menu
      user_input_from_selected_beer = gets.chomp.to_i
        if user_input_from_selected_beer == 0
          rate_beer #call method to rate beer, this should update our user_favorite instance of this beer
        elsif user_input_from_selected_beer == 1
          pairing_info #method to display pairing info , input should take selected
        elsif user_input_from_selected_beer == 2
          remove_from_favorite #method to destroy favorite object from :favorite_table
        else
          main_menu
        end
      end
    end

def rate_beer
  puts "How would you like to rate this beer?"
  puts "Please input a number from 0-5:"
    beer_rating = gets.chomp
  puts ""
  puts "We're updating BEER NUMBER:#{$user_input_from_favorite_beers} rating to #{beer_rating}"
    #execute method to update our user_favorite instance of this beer
  puts "Hang tight! We're updating rating for this beer..."
  puts ""
  sleep(1)
  puts "Boop..boop..bee..dooo"
  sleep(2)
  puts ""
  puts "Returning to main menu..."
  sleep(1)
  puts ""
  puts ""
  main_menu #return to main menu
end

def pairing_info
  puts "Here's the pairing information for BEER NUMBA: #{$user_input_from_favorite_beers}"
  #write code to display information for Beer.where(id= $user_input_from_favorite_beers)
  puts "Have a great whatever it is you're going to do ^_^"
  puts "Hit 1 to return to main menu when you're ready"
  gets.chomp
  sleep(1)
  main_menu
end

def remove_from_favorite
  sleep(1)
  puts "Hang on...we are destroying this beer from your favorites"
  puts " BEER Number: #{$user_input_from_favorite_beers} ★≡≡＼（` △´＼）"
  sleep(1)
  puts ""
  puts ""
  puts "(★▼▼)o┳*-- BEER NUMBA #{$user_input_from_favorite_beers}"
  sleep(1)
  puts ""
  puts ""
  puts "It is done. Press 1 to return to main menu"
  gets.chomp
  main_menu
  puts ""
end

def selected_beer_menu

  puts "What would you like to know about this beer?"
  puts "Use 0-3 to make your selection"
  puts "(0) Rate this beer"
  puts "(1) Pairing Info"
  puts "(2) Remove this beer from favorites"
  puts "(3) Return to main menu"
end

def beer_preferences
  puts "You have preferences, we have storage."
  puts "Please select preference settings to update:"
  puts "(0) Beer type"
  puts "(1) ABV % preference"
  puts "(2) Return to main menu"
  user_input = gets.chomp.to_i
  if user_input == 0
    beer_type_menu
  elsif user_input == 1
    abv_menu
  else
    main_menu
  end
end

def beer_type_menu
  beer_type_array = ["Blone Ales", "Ales", "IPAs", "Stouts", "Saisons"]
  puts "Your current selections: Blonde Ale, Stouts" #show favorites.beertype by userID
  puts "What types of beers would you like to add to your preferences?"
  puts "(0) Blonde Ales"
  puts "(1) Ales"
  puts "(2) IPAs"
  puts "(3) Stouts"
  puts "(4) Saisons"
  puts "(5) Return to main menu"
  add_to_pref = gets.chomp #this basically will store the index

  if add_to_pref == 5
    main_menu
  else #execute method to create favorite instance
    puts "Executing code to update preference with #{add_to_pref}"
    puts "Your preference has been saved. Please hit 1 to return to main menu"
    gets.chomp
    main_menu
  end
end

def abv_menu
  abv_array = ["Light", "Medium", "Strong"]
  puts "Your current selections: Light, Medium" #show favorites.beertype by userID
  puts "What types of beers would you like to add to your preferences?"
  puts "(0) Light 0.1% - 3.9% abv"
  puts "(1) Medium 3.90 - 5.9% abv"
  puts "(2) Strong 6% + abv"
  puts "(3) Return to main menu"
  add_to_pref = gets.chomp.to_i #this basically will store the index
  if add_to_pref == 5
    main_menu
  else #execute method to create favorite instance
    puts "Executing code to update preference with #{add_to_pref}"
    puts "Your preference has been saved. Please hit 1 to return to main menu"
    gets.chomp
    main_menu
  end
end

def discover_beers_menu
  puts "How would you like to discover?"
  puts "Please select 0-9"
  puts "(0) Search by most popular beers"
  puts "(1) See recommendations based on my preferences"
  puts "(2) Return to main menu"
  user_input = gets.chomp.to_i
  if user_input == 0
    most_popular_beers
  elsif user_input == 1
  beer_recommendations
  else
    main_menu
  end
end

def most_popular_beers
  #method to search favorites_table for most common
  puts "Here are the top beers added by BeerBud users!"
  puts "Select 0-9 to add to your favorites or return to main_menu"
  puts "        Name    |     Type      |   ABV       |  Num Times Fav. "
  puts "     ---------- | ------------  | ----------- | --------------- "
  puts "(0)  Beer A     |     IPA       | 5.4%        |   13,521        "                    #code should pull from User's preference_join_table each puts line should equal to array index?
  puts "(1)  Beer B     |     IPA       | 5.4%        |   12,323        "
  puts "(2)  Beer C     |     IPA       | 5.4%        |   8,201         "
  puts "(3)  Beer D     |     IPA       | 5.4%        |   7,000         "
  puts "(4)  Beer E     |     IPA       | 5.4%        |   5,000         "
  puts "(5)  Beer F     |     IPA       | 5.4%        |   2,000         "
  puts "(6)  Beer G     |     IPA       | 5.4%        |   1,000         "
  puts "(7)  Beer H     |     IPA       | 5.4%        |   1,000         "
  puts "(8)  Beer I     |     IPA       | 5.4%        |    5            "
  puts "     -----------------------------------------------------------"
  puts "(9)  return to main menu"
  user_input_from_popular_beers = gets.chomp.to_i
    if user_input_from_popular_beers == 9
      main_menu
    else
      #call method to add beer to favorite, add by array?
      puts "Hang on we're adding beer NUMBAAA #{user_input_from_popular_beers} to your fav."
      sleep(1)
      puts "It is done."
      sleep(1)
      puts "(1) to return to main_menu"
      puts "(2) add another beer to favorites"
      user_input = gets.chomp.to_i
        if user_input == 1
          main_menu
        else
        most_popular_beers
        end
      end
    end



# def most_popular_type
#   #method to search favorites_table for most common
#   puts "Here are the top beers added by BeerBud users!"
#   puts "select 0-9 to add to your favorites or return to main_menu"
#   puts "        Name    |     Type      |   ABV       |  Num Times Fav. "
#   puts "     ---------- | ------------  | ----------- | --------------- "
#   puts "(0)  Beer A     |     IPA       | 5.4%        |   13,521        "                    #code should pull from User's preference_join_table each puts line should equal to array index?
#   puts "(1)  Beer B     |     IPA       | 5.4%        |   12,323        "
#   puts "(2)  Beer C     |     IPA       | 5.4%        |   8,201         "
#   puts "(3)  Beer D     |     IPA       | 5.4%        |   7,000         "
#   puts "(4)  Beer E     |     IPA       | 5.4%        |   5,000         "
#   puts "(5)  Beer F     |     IPA       | 5.4%        |   2,000         "
#   puts "(6)  Beer G     |     IPA       | 5.4%        |   1,000         "
#   puts "(7)  Beer H     |     IPA       | 5.4%        |   1,000         "
#   puts "(8)  Beer I     |     IPA       | 5.4%        |    5            "
#   puts "     -----------------------------------------------------------"
#   puts "(9)  return to main menu"
#   puts "We're adding BEER NUMBAAA #{favorite_selection} to your favorites list"
#   #if max 8 put, sorry you've already reached your limit of favorites. Please remove 1 from your list while we learn more about coding.
#   puts "It is done."
#   puts "(1) to return to main_menu"
#   puts "(2) to return to beer recommendations"
#   user_input = gets.chomp.to_i
#   if user_input == 1
#     main_menu
#   else
#     most_popular_type
#   end
# end

def beer_recommendations
  #mvp - list 9 beers from join table
  #stretch - add next/previous pagination option
  puts "Hooooold on tight! We're Searching for beers based on your preferences"
  sleep(1)
  puts "..."
  sleep(1)
  puts "Here are some beers we think you'd like. Select 0-9 to add to your favorite or return to menu"
  puts "        Name    |     Type      |   ABV    "
  puts "     ---------- | ------------  | ---------"
  puts "(0)  Beer A     |     IPA       | 5.4%     "  #code should pull from User's preference_join_table each puts line should equal to array index?
  puts "(1)  Beer B     |     IPA       | 5.4%     "
  puts "(2)  Beer C     |     IPA       | 5.4%     "
  puts "(3)  Beer D     |     IPA       | 5.4%     "
  puts "(4)  Beer E     |     IPA       | 5.4%     "
  puts "(5)  Beer F     |     IPA       | 5.4%     "
  puts "(6)  Beer G     |     IPA       | 5.4%     "
  puts "(7)  Beer H     |     IPA       | 5.4%     "
  puts "(8)  Beer I     |     IPA       | 5.4%     "
  puts "(9)  Return to main menu"
  favorite_selection = gets.chomp.to_i
  #method to create favorite instance
  puts "We're adding BEER NUMBAAA #{favorite_selection} to your favorites list"
  #if max 8 put, sorry you've already reached your limit of favorites. Please remove 1 from your list while we learn more about coding.
  puts "It is done."
  puts "(1) to return to main_menu"
  puts "(2) to return to beer recommendations"
    user_input = gets.chomp.to_i
    if user_input == 1
      main_menu
    else
      beer_recommendations
    end

  # beer_recommendations
  # gets.chomp
  end

def change_menu(user_main_menu_input)
  sleep(1)
  if $user_main_menu_input == 1
    favorite_beers #execute favorite beers method
  elsif $user_main_menu_input == 2
    beer_preferences #executes #beer_preferences method
  elsif $user_main_menu_input == 3
    puts discover_beers_menu #execute discover_beers_menu method
  elsif $user_main_menu_input == 4
    puts "(●´▽｀●)_旦”☆”旦_(○´ー｀○)"
    sleep(1)
    puts "Byeeee and enjoy your drink!"
    sleep(1)
    exit!
  else
    sleep(1)
    puts "Had a bit of drink eh? Please select a valid input (1-4)"
    sleep(1)
    puts "1. View my favorites"
    puts "2. Access beer preferences"
    puts "3. Discover new beers"
    puts "4. Close program and drink"
  end
end
