class Application < ActiveRecord::Base
  belongs_to :organization
  has_many :credentials
  has_many :attachments, as: :attachable
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator'
  resourcify

  validates_presence_of  :name, :organization_id

  validates_format_of :name, :with => /[\w \.\-@]+/,:message => "can only contain letters and numbers."
  validates_length_of :name, :within => 3..50, :too_long => "name is too long", :too_short => "name is too short"
  validates_uniqueness_of :name, scope: :organization_id

  accepts_nested_attributes_for :credentials
end
