# == Schema Information
#
# Table name: user_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserType < ActiveRecord::Base
  attr_accessible :name
  has_many :users
  validates :name, presence: true, length: { maximum: 50, minimum:3 }
end
