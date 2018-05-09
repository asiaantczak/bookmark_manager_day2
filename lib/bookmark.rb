require 'pg'
require 'uri'

class Bookmark
  attr_reader :url, :title

  def initialize(url, title)
    @url = url
    @title = title
  end

  def self.all
    urls = []
    rs = set_database.exec 'SELECT * FROM bookmarks'

    rs.each do |row|
      urls << { url: row['url'], title: row['title']}
    end

    urls
  end

  def self.add(website, title)
    fail 'invalid url' unless website =~ /\A#{URI::regexp(['http', 'https'])}\z/
    set_database.exec "INSERT INTO bookmarks (url, title) VALUES('#{website}', '#{title}');"
  end

  private

  def self.set_database
    if ENV['RACK_ENV'] == 'test'
      con = PG.connect dbname: 'bookmark_manager_test'
    else
      con = PG.connect dbname: 'bookmark_manager'
    end
    con
  end
end
