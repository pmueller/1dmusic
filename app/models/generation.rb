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

  validates_length_of :current, minimum: 20, allow_blank: false

  attr_accessible :current

  def self.first_generation_string
    "00000000000000000000"
  end

  def music_part
    length = current.length
    current[ (length / 2 - 7)..(length / 2 + 6) ]
  end

  def update_generation_string(m_part)
    length = current.length
    self.current = "#{current[0...(length/2 - 7)]}#{m_part}#{current[(length/2 + 7)..length]}"
    save!
  end
end
