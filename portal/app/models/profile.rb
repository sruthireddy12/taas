class Profile < ActiveRecord::Base
  belongs_to :user
  validates :mobile_number,   :presence => {:message => 'please enter valid number'},
                             :numericality => true,
                             :length => { :minimum => 10, :maximum => 15 }
end
