class Profile < ActiveRecord::Base
  belongs_to :user
  validates_format_of :mobile_number, with: /\A[\d() +-]{8,20}\z/,
    message: "please enter valid format. Allowed only numbers, spaces,( ) + - ", allow_blank: true
end
