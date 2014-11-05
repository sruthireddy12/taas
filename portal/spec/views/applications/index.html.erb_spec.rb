require 'rails_helper'

RSpec.describe "applications/index", :type => :view do
  before(:each) do
    assign(:applications, [
      Application.create!(
        :name => "Name",
        :description => "MyText",
        :url => "Url",
        :creator => 1,
        :organization => nil
      ),
      Application.create!(
        :name => "Name",
        :description => "MyText",
        :url => "Url",
        :creator => 1,
        :organization => nil
      )
    ])
  end

  it "renders a list of applications" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
