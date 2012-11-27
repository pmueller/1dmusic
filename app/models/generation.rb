# == Schema Information
#
# Table name: generations
#
#  id         :integer          not null, primary key
#  current    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Generation < ActiveRecord::Base
  attr_accessible :current
end
