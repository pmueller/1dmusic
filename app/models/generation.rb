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

  validates_length_of :current, minimum: 14, maximum: 14, allow_blank: false

  attr_accessible :current

  def self.first_generation_string
    "00000000000000"
  end

end
