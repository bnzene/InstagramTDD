require 'rails_helper.rb'

feature 'Deleting posts' do
  background do
    post = create(:post, caption: 'Abs for daysss')
    visit '/'
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
  end
  scenario 'Can delete a single post' do
    click_link 'Delete Post'
    expect(page).to have_content("Problem solved! Post deleted.")
    expect(page).not_to have_content('Abs for daysss')
  end
end
