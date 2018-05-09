feature 'view links' do
  scenario 'shows links on the homepage' do
    con = PG.connect :dbname => 'bookmark_manager_test'
    con.exec "INSERT INTO bookmarks VALUES(1, 'http://makersacademy.com');"
    visit('/')
    expect(page).to have_content 'http://makersacademy.com'
  end
end
