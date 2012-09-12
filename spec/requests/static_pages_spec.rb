require 'spec_helper'

describe "Static pages" do

  describe "GET /" do
    it "should display our homepage" do
      visit root_url
      page.should have_content "Welcome"
    end
  end

end
