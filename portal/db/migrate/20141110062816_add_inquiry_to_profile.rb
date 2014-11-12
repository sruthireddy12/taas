class AddInquiryToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :inquiry, :text
  end
end
