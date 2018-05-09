ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'

require 'capybara'
require 'capybara/rspec'
require 'rspec'

Capybara.app = BookmarkManager


RSpec.configure do |config|

  config.before(:each) do
    con = PG.connect :dbname => 'bookmark_manager_test'
    con.exec "TRUNCATE TABLE bookmarks"
  end
end
