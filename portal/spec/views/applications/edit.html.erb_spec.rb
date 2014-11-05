require 'rails_helper'

RSpec.describe "applications/edit", :type => :view do
  before(:each) do
    @application = assign(:application, Application.create!(
      :name => "MyString",
      :description => "MyText",
      :url => "MyString",
      :creator => 1,
      :organization => nil
    ))
  end

  it "renders the edit application form" do
    render

    assert_select "form[action=?][method=?]", application_path(@application), "post" do

      assert_select "input#application_name[name=?]", "application[name]"

      assert_select "textarea#application_description[name=?]", "application[description]"

      assert_select "input#application_url[name=?]", "application[url]"
    end
  end
end
