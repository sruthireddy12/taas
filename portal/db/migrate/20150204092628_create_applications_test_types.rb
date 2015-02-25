class CreateApplicationsTestTypes < ActiveRecord::Migration
  def change
    create_table :applications_test_types do |t|
    	t.references :application
    	t.references :test_type
    end
    add_index(:applications_test_types, [ :application_id, :test_type_id ])
  end
end