class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :role
      t.string :username
      t.string :password
      t.references :application, index: true

      t.timestamps
    end
  end
end
