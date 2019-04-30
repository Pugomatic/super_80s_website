class AddSites < ActiveRecord::Migration[5.2]
  def change
    Site.create domain: 'choppercommando.app', name: 'chopper_commando', layout: 'chopper_commando'
    Site.create domain: 'super80sworld.com', name: 'super_80s_world', layout: 'application'
    Site.create domain: 'taptapgood.com', name: 'tap_tap_good', layout: 'tap_tap_good'
  end
end
