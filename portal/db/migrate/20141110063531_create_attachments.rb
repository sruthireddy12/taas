class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file_path
      t.string :file_type
      t.integer :attachable_id
      t.string  :attachable_type

      t.timestamps
    end
  end
end
