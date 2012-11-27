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

  attr_accessible :current
end
