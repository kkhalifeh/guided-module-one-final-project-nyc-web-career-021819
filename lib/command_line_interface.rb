require 'pry'
class BeerBud

attr_reader :current_user, :user_main_menu_input, :user_input_from_favorite_beers, :user_input_from_selected_beer, :selected_fav_beer, :user_prefs_strength

attr_accessor :favorite_list_array


def run
  welcome
  get_username
  main_menu_loop
end

def main_menu_loop
  main_menu
  loop do
    change_menu(user_main_menu_input)
  end
end


def welcome
 puts "-------------------------------------------------------------".bold.yellow
  a = Artii::Base.new :font => 'slant'
 puts a.asciify('BeerBud!').colorize(:red)
 puts "-------------------------------------------------------------".bold.yellow
  puts "Welcome to BeerBud!"
end


  def get_username
    #method to check if username exists in data base
    # if it doesnt, create it a new user
    puts "Please enter your user name:".bold.red
    @current_user_name = gets.chomp.downcase
    if User.find_by(user_name: @current_user_name).nil?
      puts "-------------------------------------------------------------".bold.yellow
      puts "Hey, you're new here. Welcome to BeerBud :)."
      #method to create new user
      User.create(user_name: @current_user_name)
      sleep (1)
      @current_user = User.find_by(user_name: @current_user_name)
      puts "Let's get started by making a few selections."
      sleep(1)
      beer_type_menu_onboard
    else @current_user = User.find_by(user_name: @current_user_name)
      puts "Welcome back #{@current_user.user_name}."
    end
    # @current_user = User.find_or_create_by(user_name: name)
    sleep(1)
  end

  # def new_user_onboard
  #   puts "Let's get you started by setting some preferences"
  #   beer_type_menu_onboard
  #   abv_menu_onboard
  #
  #   #help user add 1 beer_style_preference and 1 beer_strength preference
  #
  # end

  def beer_type_menu_onboard
    beer_type_array = ["Pilsener", "Ale", "Tripel", "Lager", "Porter", "Stout"," Kölsch", "Weisse"]
    puts "Let us know what type of beers you like."
    sleep (1)
    "Please press any key from (0) - (7) to make your selection.".bold.red
    puts "-------------------------------------------------------------".bold.yellow
    puts "(0) Pilsener"
    puts "(1) Ale"
    puts "(2) Tripel"
    puts "(3) Lager"
    puts "(4) Porter"
    puts "(5) Stout"
    puts "(6) Kölsch"
    puts "(7) Weisse"
    puts "-------------------------------------------------------------".bold.yellow
    add_to_pref = gets.chomp.to_i
    Preference.find_or_create_by(user_id: User.find_by(user_name: @current_user_name).id, beer_style: beer_type_array[add_to_pref])

    puts "Hooooold tight. We're updating your preferences to include #{beer_type_array[add_to_pref]} beers"
    sleep(1)
    puts "..."
    sleep(1)
    puts "Your preference has been saved!"
    puts "-------------------------------------------------------------".bold.yellow
    puts "(1) to select more styles."
    puts "(2) to continue onboarding."
    puts "-------------------------------------------------------------".bold.yellow
    user_input = gets.chomp.to_i
    until user_input == 1 || user_input == 2
      string_arr = ["Had a bit of drink eh? Please select (1) or (2)", "Seriously, please select (1) or (2)", "Put your drink down and gently press (1) or (2)", "We can go all day. (1) or (2)", "No seriously, you can't beat our loop. Please select (1) or (2)", "Ah fine, you win. SIKE. Please select (1) or (2)"]
      sleep (1)
      puts "#{string_arr.sample}".red
      puts "-------------------------------------------------------------".bold.yellow
      puts "(1) to select more styles."
      puts "(2) to continue onboarding."
      puts "-------------------------------------------------------------".bold.yellow
      user_input = gets.chomp.to_i
    end
    if user_input == 1
      beer_type_menu_onboard
    else
      abv_menu_onboard
    end
  end

  def abv_menu_onboard
    beer_strength_array = ["Light", "Medium", "Strong"]
    puts "Cool! Now let's select how strong you like your beers.".bold.red
    sleep(1)
    puts "Please press any key from (0) - (2) to make your selection.".bold.red
    puts "-------------------------------------------------------------".bold.yellow
    puts "(0) Light 0.1% - 3.9% abv"
    puts "(1) Medium 3.90 - 5.9% abv"
    puts "(2) Strong 6% + abv"
    puts "-------------------------------------------------------------".bold.yellow
    add_to_pref = gets.chomp.to_i
      Preference.find_or_create_by(user_id: User.find_by(user_name: @current_user_name).id, beer_strength: beer_strength_array[add_to_pref])
      puts "Hang on...we're updating your preference with #{beer_strength_array[add_to_pref]} beers!"
      sleep(1)
      puts "..."
      sleep(1)
      puts "Your preference has been saved!"
      puts "-------------------------------------------------------------".bold.yellow
      puts "(1) to select additional options."
      puts "(2) to continue onboarding."
      puts "-------------------------------------------------------------".bold.yellow
      user_input = gets.chomp.to_i
      until user_input == 1 || user_input == 2
        sleep(1)
        string_arr = ["Had a bit of drink eh? Please select (1) or (2)", "Seriously, please select (1) or (2)", "Put your drink down and gently press (1) or (2)", "We can go all day. (1) or (2)", "No seriously, you can't beat our loop. Please select (1) or (2)", "Ah fine, you win. SIKE. Please select (1) or (2)"]
        puts "#{string_arr.sample}".red
        puts "-------------------------------------------------------------".bold.yellow
        puts "(1) to select more styles."
        puts "(2) to continue onboarding."
        puts "-------------------------------------------------------------".bold.yellow
        user_input = gets.chomp.to_i
      end
      if user_input == 1
        abv_menu_onboard
      else
        main_menu_loop
      end
  end

  def main_menu

    puts "What can I do for you?".bold.red
    puts "-------------------------------------------------------------".bold.yellow
    sleep(1)
    puts "(1) View my favorites"
    puts "(2) Access beer preferences"
    puts "(3) Discover new beers"
    puts "(4) Close program and drink"
    puts "-------------------------------------------------------------".bold.yellow
    @user_main_menu_input = gets.chomp.to_i
  end

  def favorite_beers
    self.current_user.favorites.reload
    @favorite_list_array = self.current_user.favorites
    if favorite_list_array == []
      puts "You have not selected any favorites!"
      puts "Hit 1 to return to main menu when you're ready"
      gets.chomp
      sleep(1)
      main_menu_loop
    else
    puts "Your favorites list:"
    puts "Use 0-#{favorite_list_array.length} to make your selection"
    fav_list = favorite_list_array.each_with_index do |beer, index|
      puts "(#{index}) #{beer.beer.name}"
    end
    puts "(#{fav_list.length}) Return to main menu"
    @user_input_from_favorite_beers = gets.chomp.to_i
    puts user_input_from_favorite_beers
      if user_input_from_favorite_beers == fav_list.length
        main_menu_loop
      else
        @selected_fav_beer = favorite_list_array[user_input_from_favorite_beers].beer
        puts "CURRENT BEER SELECTION: #{selected_fav_beer.name}"
        selected_beer_menu
        @user_input_from_selected_beer = gets.chomp.to_i
          if user_input_from_selected_beer == 0
            rate_beer #call method to rate beer, this should update our user_favorite instance of this beer
          elsif user_input_from_selected_beer == 1
            pairing_info #method to display pairing info , input should take selected
          elsif user_input_from_selected_beer == 2
            remove_from_favorite #method to destroy favorite object from :favorite_table
        else
          main_menu_loop
        end
      end
    end
  end

  def pairing_info
    puts "Here's the pairing information for BEER NUMBA: #{user_input_from_favorite_beers} (#{selected_fav_beer.name})"
    pairings = selected_fav_beer.foodPairings
    glassware = selected_fav_beer.glassware
    puts "Have it with: #{pairings}"
    puts "Serve it in a: #{glassware}"
    #write code to display information for Beer.where(id= $user_input_from_favorite_beers)
    puts "Have a great whatever it is you're going to do ^_^"
    puts "Hit 1 to return to main menu when you're ready"
    gets.chomp
    sleep(1)
    main_menu_loop
  end

  def remove_from_favorite
    sleep(1)
    puts "Hang on...we are destroying this beer from your favorites"
    puts " BEER Number: #{user_input_from_favorite_beers} ★≡≡＼（` △´＼）"
    sleep(1)
    puts ""
    puts ""
    puts "(★▼▼)o┳*-- BEER NUMBA #{user_input_from_favorite_beers}"
    sleep(1)
    Favorite.find_or_create_by(user_id: self.current_user.id, beer_id: selected_fav_beer.id).destroy
    @favorite_list_array = favorite_list_array.select {|fav_item| fav_item.beer_id != self.selected_fav_beer.id}
    puts ""
    puts ""
    puts "It is done. Press 1 to return to main menu"
    gets.chomp
    main_menu_loop
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
  #
  # [15] pry(main)> Preference.new(beer_style: "Ale", beer_strength: "Medium")
  # => #<Preference:0x00007fd7d0c73828 id: nil, user_id: nil, beer_style: "Ale", beer_strength: "Medium">

  def user_beer_style_preferences
    Preference.where(user_id:self.current_user.id).map do |preference|
      preference.beer_style
    end.compact
  end

  def beer_type_menu
    beer_type_array = ["Pilsener", "Ale", "Tripel", "Lager", "Porter", "Stout"," Kölsch", "Weisse"]
    puts ""
    puts "Your current preferences are #{user_beer_style_preferences}."
    puts ""
    puts "What types of beers would you like to add to your preferences?"
    puts "(0) Pilsener"
    puts "(1) Ale"
    puts "(2) Tripel"
    puts "(3) Lager"
    puts "(4) Porter"
    puts "(5) Stout"
    puts "(6) Kölsch"
    puts "(7) Weisse"
    puts "(8) Return to main menu"
    add_to_pref = gets.chomp.to_i #this basically will store the index

    if add_to_pref == 8
      main_menu
    else
      Preference.find_or_create_by(user_id: self.current_user.id, beer_style: beer_type_array[add_to_pref])
      puts "Hooooold tight. We're updating your preferences to include #{beer_type_array[add_to_pref]} beers"
      sleep(1)
      puts "Your preference has been saved. (1) to return to options."
      gets.chomp
      beer_type_menu
    end
  end

  def user_beer_strength_preferences
    Preference.where(user_id:self.current_user.id).map do |preference|
      preference.beer_strength
    end.compact
  end

  def abv_menu
    beer_strength_array = ["Light", "Medium", "Strong"]
    puts "Your current selections: #{user_beer_strength_preferences}"
    puts "What types of beers would you like to add to your preferences?"
    puts "(0) Light 0.1% - 3.9% abv"
    puts "(1) Medium 3.90 - 5.9% abv"
    puts "(2) Strong 6% + abv"
    puts "(3) Return to main menu"
    add_to_pref = gets.chomp.to_i
    if add_to_pref == 3
      main_menu_loop
    else
      Preference.find_or_create_by(user_id: self.current_user.id, beer_strength: beer_strength_array[add_to_pref])
      puts "Hang on...we're updating your preference with #{beer_strength_array[add_to_pref]} beers!"
      sleep(1)
      puts "Your preference has been saved! (1) to return to options"
      gets.chomp
      abv_menu
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


  # def most_popular_beers
  #   #method to search favorites_table for most favorite
  #   puts "Here are the top beers added by BeerBud users!"
  #   puts "Select 0-9 to add to your favorites or return to main_menu"
  #   puts "        Name    |     Type      |   ABV       |  Num Times Fav. "
  #   puts "     ---------- | ------------  | ----------- | --------------- "
  #   puts "(0)  Beer A     |     IPA       | 5.4%        |   13,521        "                    #code should pull preference_join_table each puts line should equal to array index?
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
  #   user_input_from_popular_beers = gets.chomp.to_i
  #     if user_input_from_popular_beers == 9
  #       main_menu
  #     else
  #       #call method to add beer to favorite, add by array?
  #       puts "Hang on we're adding beer NUMBAAA #{user_input_from_popular_beers} to your fav."
  #       sleep(1)
  #       puts "It is done."                                                                     
  #       sleep(1)
  #       puts "(1) to return to main_menu"
  #       puts "(2) add another beer to favorites"
  #       user_input = gets.chomp.to_i
  #         if user_input == 1
  #           main_menu
  #         else
  #         most_popular_beers
  #         end
  #     end
  #   end




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

  # puts "Your favorites list:"
  # puts "Use 0-#{favorite_list_array.length} to make your selection"
  # fav_list = favorite_list_array.each_with_index do |beer, index|
  #   puts "(#{index}) #{beer.beer.name}"
  # end
  # puts "(#{fav_list.length}) Return to main menu"
  # @user_input_from_favorite_beers = gets.chomp.to_i
  # @selected_fav_beer = favorite_list_array[user_input_from_favorite_beers].beer
  # puts user_input_from_favorite_beers
  #   if user_input_from_favorite_beers == fav_list.length
  #     main_menu_loop
  #   else

  # fav_list = favorite_list_array.each_with_index do |beer, index|
  #   puts "(#{index}) #{beer.beer.name}"
  def most_popular_beers
    puts "Here are the top beers added by BeerBud users!"
    most_popular = Favorite.group('beer_id').order('count_all DESC').count
    most_popular = most_popular.keys
    top10 = most_popular.first(10)
    puts "Select 0-#{top10.length - 1} to add to your favorites or #{top10.length} to return to menu"
      top10.each_with_index do |beer,index|
      puts "(#{index})  | Name: #{Beer.find(beer).name} | ABV: #{Beer.find(beer).abv})"
    end
    puts "(#{top10.length})  Return to main menu"
    popular_selection = gets.chomp.to_i
    if popular_selection == top10.length
      main_menu_loop
    end
    # binding.pry
    Favorite.find_or_create_by(user_id: self.current_user.id, beer_id: top10[popular_selection])
    puts "We're adding BEER NUMBAAA #{popular_selection} to your favorites list"

    puts "It is done."
    puts "(1) to return to main menu"
    puts "(2) to return to most popular beers"
      user_input = gets.chomp.to_i
      if user_input == 1
        main_menu
      else
        most_popular_beers
      end
  end

  def beer_recommendations
    @user_prefs_strength = user_beer_strength_preferences
    beer_style_match = []
    beer_style_and_strength_match = []
    #add all beers to array by style_preference
    user_beer_style_preferences.each do |style_pref|
      beer_style_match << Beer.where(style: style_pref) #need to iterate through Beer.where(style: style_pref and shovel each beer instance into beermatch)
    end
    # binding.pry
    final_beer_selection = []
    beer_style_match.flatten.select do |beer|
        self.user_prefs_strength.each do |pref|
        if beer.strength == pref
          final_beer_selection << beer
        end
      end
    end
    final_beer_selection.uniq
    if final_beer_selection.length > 15
      final_beer_selection = final_beer_selection.first(15)
    end
    #mvp - list 9 beers from join table
    #stretch - add next/previous pagination option
    puts "Hooooold on tight! We're Searching for beers based on your preferences"

    sleep(1)
    puts "..."
    sleep(1)
    puts "Here are some beers we think you'd like. Select 0-#{final_beer_selection.length - 1} to add to your favorites or #{final_beer_selection.length} to return to menu"
    rec_list = final_beer_selection.each_with_index do |beer, index|

      puts "(#{index})  | Name: #{beer.name} | ABV: #{beer.abv})"
    end

    puts "(#{final_beer_selection.length})  Return to main menu"
    favorite_selection = gets.chomp.to_i
    if favorite_selection == final_beer_selection.length
      main_menu_loop
    end
    Favorite.create(user_id: self.current_user.id, beer_id: final_beer_selection[favorite_selection].id)
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
    if @user_main_menu_input == 1
      favorite_beers #execute favorite beers method
    elsif @user_main_menu_input == 2
      beer_preferences #executes #beer_preferences method
    elsif @user_main_menu_input == 3
      puts discover_beers_menu #execute discover_beers_menu method
    elsif @user_main_menu_input == 4
      puts "(●´▽｀●)_旦”☆”旦_(○´ー｀○)"
      sleep(1)
      puts "Byeeee and enjoy your drink!"
      sleep(1)
      exit!
    else
    # else
    #   sleep(1)
    #   puts "Had a bit of drink eh? Please select a valid input (1-4)"
    #   sleep(1)
    #   puts "(1) View my favorites"
    #   puts "(2) Access beer preferences"
    #   puts "(3) Discover new beers"
    #   puts "(4) Close program and drink"
    # end
  end
  end

end
