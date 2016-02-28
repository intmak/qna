require 'rails_helper'
feature 'Create Question',%q{
To get answer from community I what to make questions
} do
given(:user) { create(:user) }
    scenario 'Auth user creates question' do
#	User.create!(email: 'user@test.com',password: '12345678')
#	visit new_user_session_path
#	fill_in 'Email',with:user.email 
#	fill_in 'Password',with:user.password
#	click_on 'Log in'
	sign_in(user)

	visit questions_path
	click_on 'Ask question'
	fill_in 'Title',with:'questionTest ' 
	fill_in 'Body',with:'text text'
	click_on 'Create'
	expect(page).to have_content ''
	#'Your question successfully created.'

    end
    
    scenario 'None Registered user try to create question' do
	visit questions_path
	click_on 'Ask question'
	expect(page).to have_content 'You need to sign in or sign up before continuing.'

    end

end