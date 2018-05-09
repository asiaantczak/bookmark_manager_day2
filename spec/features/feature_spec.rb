feature 'view links' do
  scenario 'shows links on the homepage' do
    con = PG.connect :dbname => 'bookmark_manager_test'
    con.exec "INSERT INTO bookmarks VALUES(1, 'http://makersacademy.com');"
    visit('/')
    expect(page).to have_content 'http://makersacademy.com'
  end
end

feature 'add bookmarks' do
  scenario 'shows added bookmark' do
    visit('/')
    fill_in 'bookmark', with: 'http://youtube.com'
    click_button 'Add bookmark'
    expect(page).to have_content 'http://youtube.com'
  end
end
