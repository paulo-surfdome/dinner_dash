require 'spec_helper'
require 'capybara'

describe 'check user' do
  let :user do
      User.create(full_name: 'tony', display_name: 'tonyk', email: 't@t.com', password:'password',  password_confirmation:'password') 
   end
 
  it 'add user' do
    expect(user.full_name).to eq 'tony'
  end

  it 'get login page' do
    visit login_url
    expect(page.status_code).to eq 200
  end

  it 'login' do
    visit login_url
    fill_in 'email', :with => user.email
    fill_in 'password', :with => 'password'
    click_on 'Login'
    page.should have_content('Logged in as t@t.com')  
  end

  it 'check user role' do 
    visit login_url
    fill_in 'email', :with => user.email
    fill_in 'password', :with => 'password'
    click_on 'Login'
    expect(user.admin?).to eq false
    user.role = 1
    expect(user.admin?).to eq true
  end

  it 'logout' do
    visit login_url
    fill_in 'email', :with => user.email
    fill_in 'password', :with => 'password'
    click_on 'Login'
    page.should have_content('Logged in as t@t.com') 
    visit logout_url 
    page.should have_content('Logged out')  
  end
end
 
