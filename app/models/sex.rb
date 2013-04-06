class Sex < ActiveRecord::Base
  has_many :people
  attr_accessible :name, :redirect_uri
  validates :name, :presence => true,
            :uniqueness => true,
            :length => { :maximum => 50 }
end