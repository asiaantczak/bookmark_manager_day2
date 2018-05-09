feature 'view links' do
  scenario 'shows links on the homepage' do
    con = PG.connect :dbname => 'bookmark_manager_test'
    con.exec "INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');"
    visit('/')
    expect(page).to have_content 'http://makersacademy.com'
  end
end

feature 'add bookmarks' do
  scenario 'shows added bookmark' do
    visit('/')
    click_button 'Add bookmark'
    fill_in 'bookmark', with: 'http://youtube.com'
    click_button 'Add'
    expect(page).to have_content 'http://youtube.com'
  end

feature 'valdidate input' do
  scenario 'show error message when url is invalid' do
    visit('/')
    click_button 'Add bookmark'
    fill_in 'bookmark', with: 'youtube.dom'
    click_button 'Add'
    expect(page).to have_content 'invalid url'
  end
end

end
