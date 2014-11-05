require 'rails_helper'

RSpec.describe "applications/new", :type => :view do
  before(:each) do
    assign(:application, Application.new(
      :name => "MyString",
      :description => "MyText",
      :url => "MyString",
      :creator => 1,
      :organization => nil
    ))
  end

  it "renders new application form" do
    render

    assert_select "form[action=?][method=?]", applications_path, "post" do

      assert_select "input#application_name[name=?]", "application[name]"

      assert_select "textarea#application_description[name=?]", "application[description]"

      assert_select "input#application_url[name=?]", "application[url]"

    end
  end
end
