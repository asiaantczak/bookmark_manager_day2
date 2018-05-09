require 'bookmark'

describe Bookmark do

  describe '.all' do
    it 'returns bookmarks' do
      con = PG.connect dbname: 'bookmark_manager_test'
      con.exec "INSERT INTO bookmarks VALUES(1, 'http://makersacademy.com');"
      expect(described_class.all).to eq ['http://makersacademy.com']
    end
  end

end
