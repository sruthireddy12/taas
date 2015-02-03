class CreateApplicationRequirements < ActiveRecord::Migration
  def change
    create_table :application_requirements do |t|
    	t.string :ram
      t.string :hard_disk
      t.string :graphic_card
      t.string :browsers
      t.string :framework
      t.string :language
      t.string :database
      t.references :application

      t.timestamps
    end
  end
end
