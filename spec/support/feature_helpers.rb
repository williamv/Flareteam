module FeatureHelpers
  def visit_the_home_page
    visit '/'
  end

  def login_as user, password
    visit_the_home_page

    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button 'Sign in'

    page.should have_css('.notice', text: 'Signed in successfully')
  end

  def admin_password
    'harlot13spigot'
  end

  def guest_password
    'gusset45nailgun'
  end

  def admin
    @admin ||= FactoryGirl.create(
        :user,
        :with_organization,
        password: admin_password)
  end

  def guest
    @guest ||= FactoryGirl.create(
        :user,
        password: guest_password)
  end

  def comment_title
    @comment_title ||= Faker::Company.bs
  end

  def edit_comment
    within '.comment' do
      click_link 'Edit'
    end
  end

  def delete_comment
    click_link 'Delete Comment'
  end

  def there_should_be_no_comment
    page.should have_no_content comment_title
  end

  def activation_title
    @activation_title ||= Faker::Company.bs
  end

  def view_activation
    click_link activation_title
  end

  def fill_in_organization_details
    fill_in 'Name', with: organization_name
    fill_in 'Street address', with: Faker::Address.street_address
    fill_in 'City', with: Faker::AddressUS.city
    fill_in 'State', with: Faker::AddressUS.state_abbr
    fill_in 'Zip code', with: Faker::AddressUS.zip_code
    fill_in 'Phone', with: Faker::PhoneNumber.phone_number
    fill_in 'Primary contact name', with: Faker::Name.name
    fill_in 'Primary contact phone', with: Faker::PhoneNumber.phone_number
    fill_in 'Primary contact email', with: Faker::Internet.email
    fill_in 'Role during emergencies', with: Faker::Lorem.sentence
    select '1-10', from: 'Number of employees'
  end
end
