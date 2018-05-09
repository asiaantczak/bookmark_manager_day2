require 'bookmark'

describe Bookmark, :bookmark do
  let(:bookmark) { Bookmark.new('http://makersacademy.com', 'Makers Academy') }

  describe '#url', :url do
    it 'returns the bookmark url' do
      expect(bookmark.url).to eq 'http://makersacademy.com'
    end
  end

  describe '#title' do
    it 'returns the bookmark title' do
      expect(bookmark.title).to eq 'Makers Academy'
    end
  end

  describe '.all' do
    it 'returns bookmarks' do
      con = PG.connect dbname: 'bookmark_manager_test'
      con.exec "INSERT INTO bookmarks (url, title) VALUES('http://makersacademy.com', 'Makers Academy');"
      expect(described_class.all).to eq [{ url: 'http://makersacademy.com', title: 'Makers Academy' }]
    end
  end

  describe '#add', :add do
    it 'adds a new bookmark' do
      described_class.add('http://youtube.com', 'youtube')
      expect(described_class.all).to eq [{ url: 'http://youtube.com', title: 'youtube' }]
    end
    it 'raises error if url is invalid' do
      expect { described_class.add('youtube.dom', 'youtube') }.to raise_error 'invalid url'
    end

  end

end
