require 'rails_helper'

RSpec.describe CountersController, type: :system do
  it "creates a counter" do
    counter_count = Counter.count
    visit '/'
    click_link 'Create counter', match: :first
    
    fill_in 'Counter name', with: 'my.test.counter'
    click_button 'Generate and copy', match: :first
    password = find('input#counter_password')[:value]
    
    click_button 'Create counter'
    expect(Counter.count).to eql(counter_count + 1)
    counter = Counter.last
    expect(counter.name).to eql('my.test.counter')
    expect(counter.value).to eql(1)
    expect(counter.password).to eql(password)
    expect(counter.read_password).to be_empty
    expect(counter.created_from_ip.addr.to_s).to eql('127.0.0.1')
    
    expect(page).to have_content(%{curl -s "http://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}/counter/my.test.counter?auth=#{password}"})
    expect(page).to have_content("#{Counter.count} counters created")
  end

  it "doest't create counter without a name" do
    visit '/counters/new'
    click_button 'Create counter'
  
    message = page.find("#counter_name").native.attribute("validationMessage")
    expect(message).to eq "Please fill in this field."
  end
  
  it "doesn't create duplicate counters" do
    counter_count = Counter.count
    create_counter_with_name('my.test.counter')
    expect(Counter.count).to eql(counter_count + 1)

    create_counter_with_name('my.test.counter')
    expect(Counter.count).to eql(counter_count + 1)
    
    expect(page).to have_content('Counter name: has already been taken')
  end
  
  it "doest't create counter without a password" do
    visit '/counters/new'
    fill_in 'Counter name', with: 'my.test.counter'
    click_button 'Create counter'

    message = page.find("#counter_password").native.attribute("validationMessage")
    expect(message).to eq "Please fill in this field."

    find('button[data-target="counters.readPasswordButton"').click
    
    click_button 'Create counter'

    message = page.find("#counter_password").native.attribute("validationMessage")
    expect(message).to eq "Please fill in this field."
  end
  
  it "creates counter with separate read password" do
    visit '/counters/new'
    fill_in 'Counter name', with: 'my.test.counter'
    find('button[data-target="counters.passwordButton"').click
    password = find('input#counter_password')[:value]

    find('button[data-target="counters.readPasswordButton"').click
    read_password = find('input#counter_read_password')[:value]
    
    click_button 'Create counter'

    
    counter = Counter.last
    expect(counter.password).to eql(password)
    expect(counter.read_password).to eql(read_password)
  end
  
  it 'creates counter with start value' do
    visit '/counters/new'
    fill_in 'Counter name', with: 'my.test.counter'
    fill_in 'Start value', with: 7
    click_button 'Generate and copy', match: :first
    click_button 'Create counter'

    expect(page).to have_current_path("/counter/my.test.counter/info")
    expect(Counter.last.value).to eql(7)
  end
end

def create_counter_with_name(name)
  visit '/counters/new'
  fill_in 'Counter name', with: name
  click_button 'Generate and copy', match: :first
  click_button 'Create counter'
  expect(page).to have_current_path("/counter/#{name}/info")
end