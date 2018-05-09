require 'bookmark'

describe Bookmark, :bookmark do

  describe '.all' do
    it 'returns bookmarks' do
      con = PG.connect dbname: 'bookmark_manager_test'
      con.exec "INSERT INTO bookmarks VALUES(1, 'http://makersacademy.com');"
      expect(described_class.all).to eq ['http://makersacademy.com']
    end
  end

  describe '#add' do
    it 'adds a new bookmark' do
      described_class.add('http://youtube.com')
      expect(described_class.all).to eq ['http://youtube.com']
    end
  end

end
