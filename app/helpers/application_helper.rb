# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def yes_no(bool ,yes = 'yes', no = 'no')
    bool ? yes : no
  end

end

