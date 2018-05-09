feature 'view titles', :title do
  scenario 'shows title on the homepage' do
    con = PG.connect :dbname => 'bookmark_manager_test'
    con.exec "INSERT INTO bookmarks (url, title) VALUES('http://makersacademy.com', 'Makers Academy');"
    visit('/')
    expect(page).to have_content 'Makers Academy'
  end
end

feature 'add bookmarks' do
  scenario 'shows added bookmark' do
    visit('/')
    click_button 'Add bookmark'
    fill_in 'bookmark', with: 'http://youtube.com'
    fill_in 'title', with: 'youtube'
    click_button 'Add'
    expect(page).to have_content 'youtube'
  end

feature 'valdidate input' do
  scenario 'show error message when url is invalid' do
    visit('/')
    click_button 'Add bookmark'
    fill_in 'bookmark', with: 'youtube.dom'
    click_button 'Add'
    expect(page).to have_content 'Invalid url'
  end
end

feature 'delete bookmark' do
  scenario 'deletes bookmark' do
    visit('/')
    click_button 'Add bookmark'
    fill_in 'bookmark', with: 'http://youtube.com'
    fill_in 'title', with: 'youtube'
    click_button 'Add'
    click_button 'Delete bookmark'
    fill_in 'title', with: 'youtube'
    click_button 'Delete'
    expect(page).not_to have_content 'youtube'
  end
end

feature 'update bookmark' do
  scenario 'updates bookmark' do
    visit('/')
    click_button 'Add bookmark'
    fill_in 'bookmark', with: 'http://youtube.com'
    fill_in 'title', with: 'youtube'
    click_button 'Add'
    click_button 'Update bookmark'
    fill_in 'original_title', with: 'youtube'
    fill_in 'new_title', with: 'Video channel'
    click_button 'Update'
    expect(page).not_to have_content 'youtube'
    expect(page).to have_content 'Video channel'
  end

  scenario 'updating non-existent bookmark gives error' do
    visit('/')
    click_button 'Update bookmark'
    fill_in 'original_title', with: 'youtube'
    fill_in 'new_title', with: 'Video channel'
    click_button 'Update'
    expect(page).to have_content 'Invalid title'
  end
end

end
