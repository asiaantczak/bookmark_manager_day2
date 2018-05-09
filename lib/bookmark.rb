require 'pg'

class Bookmark

  def self.all

    if ENV['RACK_ENV'] == 'test'
      urls = []

      con = PG.connect dbname: 'bookmark_manager_test'
      rs = con.exec 'SELECT * FROM bookmarks'

      rs.each do |row|
        urls << row['url']
      end

    else
      urls = []

      con = PG.connect dbname: 'bookmark_manager'
      rs = con.exec 'SELECT * FROM bookmarks'

      rs.each do |row|
        urls << row['url']
      end
    end

    urls
  end
end
