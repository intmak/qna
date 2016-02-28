require 'rails_helper'
feature 'User sign in',%q{
In order to be ableto ask question
As an user 
I want to be able sign in
} do
given(:user) { create(:user) }
    scenario 'Registered user try to sign in' do
	sign_in(user)
#	visit new_user_session_path
#	fill_in 'Email',with: user.email 
#	fill_in 'Password',with: user.password
#	save_and_open_page
#	click_on 'Log in'
	
	expect(page).to have_content 'Signed in successfully.'
	expect(current_path).to eq root_path
    end
    
    scenario 'None Registered user try to sign in' do
	visit new_user_session_path
	fill_in 'Email',with:'user_none@test.com' 
	fill_in 'Password',with:'12345678'
	click_on 'Log in'
	expect(page).to have_content 'Invalid email or password'
	expect(current_path).to eq new_user_session_path
    end

end