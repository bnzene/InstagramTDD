require 'rails_helper.rb'

feature 'Editing posts' do
  background do
    post = create(:post)
    visit '/'
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
    click_link 'Edit Post'
  end
  scenario 'Can edit a post' do
    fill_in 'Caption', with: "Oh god, you weren't meant to see this picture!"
    click_button 'Update Post'
    expect(page).to have_content("Post updated hombre.")
    expect(page).to have_content("Oh god, you weren't meant to see this picture!")
  end
  scenario 'Errors when user tries to update post without an image' do
    attach_file('Image', 'spec/files/images/CVREADME.md')
    click_button
    expect(page).to have_content("Something is wrong with your form!")
  end
  # starting after the actions in the background block:
  # fill in the 'Image' field with nothing
  # click the 'Update Post' buton
  # expect to see the message: 'Something is wrogn with your form!'
end
