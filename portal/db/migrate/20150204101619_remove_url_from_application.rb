class RemoveUrlFromApplication < ActiveRecord::Migration
  def change
    remove_column :applications, :url, :string
  end
end
