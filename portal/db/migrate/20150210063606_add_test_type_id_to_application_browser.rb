class AddTestTypeIdToApplicationBrowser < ActiveRecord::Migration
  def change
  	add_column :application_browsers, :test_type_id, :integer
  end
end
