require "spec_helper"

describe "PersistDataController" do

  describe "saves voter data to the app's database" do

    # Create an NBEC OAuth authenticated user
    before :each do
      visit new_user_registration_url

      fill_in "Email", :with => "test@email.com"
      fill_in "Password", :with => "password"
      fill_in "Password confirmation", :with => "password"
      click_button "Sign up"

      page.should have_content "Candidate Connect"

      current_user = User.last
      current_user.stub(:nbec) { double("nbec") }
      NbecToken.stub(:exists?) { current_user.id }

    end

    it 'should import voters' do
      # Visit the homepage again to ensure that we've been mock
      # OAuth "authenticated."
      visit root_url
      page.should have_content "Disconnect"

      # Ask the app to download the voter data.
      visit persist_data_url
      click_button "Download data"
      page.should have_content "Voter data parsed successfully."
      page.should have_content "Number of voters created: 1."

      # Check that the voter has actually been imported.
      visit voters_url
      page.should have_content "Test"
      page.should have_content "User"
      page.should have_content "example@email.com"
    end

  end

end
