# == Schema Information
#
# Table name: generations
#
#  id         :integer          not null, primary key
#  current    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  song_id    :integer
#

class Generation < ActiveRecord::Base
  belongs_to :song

  validates_length_of :current, minimum: 12, maximum: 12, allow_blank: false

  attr_accessible :current
end
