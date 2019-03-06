require_relative "../config/environment.rb"
require_relative '../lib/command_line_interface.rb/'

ActiveRecord::Base.logger = false
BeerBud.new.run
# welcome
# user_name = get_username
# #user name is returned downcase
# # User .find_by("name) to evaluate if new or returning user
# #assuming returning user
#
#
# main_menu
# loop do
# change_menu($user_main_menu_input)
# end
