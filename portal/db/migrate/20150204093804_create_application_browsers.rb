class CreateApplicationBrowsers < ActiveRecord::Migration
  def change
    create_table :application_browsers do |t|
      t.integer :application_id
      t.integer :browser_id
      t.string  :version

      t.timestamps
    end
  end
end
