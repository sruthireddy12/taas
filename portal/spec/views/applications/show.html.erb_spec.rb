require 'rails_helper'

RSpec.describe "applications/show", :type => :view do
  before(:each) do
    @application = assign(:application, Application.create!(
      :name => "Name",
      :description => "MyText",
      :url => "Url",
      :creator => 1,
      :organization => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/1/)
  end
end
