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

  def match(current_gen, i)
    ret = false

    if (i > 0 && i < 11)
      if current_gen[i-1] == to_match[0] && current_gen[i] == to_match[1] && current_gen[i+1] == to_match[2]
        ret = true
      end
    end

    ret
  end
end
