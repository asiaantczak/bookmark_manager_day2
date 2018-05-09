require 'pg'

class Bookmark

  def self.all
    urls = []
    rs = set_database.exec 'SELECT * FROM bookmarks'

    rs.each do |row|
      urls << row['url']
    end

    urls
  end

  def self.add(website)
    set_database.exec "INSERT INTO bookmarks (url) VALUES('#{website}');"
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
