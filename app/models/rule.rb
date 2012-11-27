# == Schema Information
#
# Table name: rules
#
#  id         :integer          not null, primary key
#  to_match   :string(255)
#  new_cell   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  song_id    :integer
#

class Rule < ActiveRecord::Base
  belongs_to :song

  attr_accessible :new_cell, :to_match
end
