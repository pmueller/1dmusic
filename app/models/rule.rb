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

  scope :long_first, order('length(to_match) DESC')
  scope :old_first, order("created_at ASC")  

  attr_accessible :new_cell, :to_match

  def match(current_gen, i)
    ret = false

    if ( (i - to_match.length / 2) >= 0 && (i + to_match.length / 2) < current_gen.length)
        ret = true
       
        mid_num = to_match.length / 2 

        to_match.length.times do |j|
          ret = false if to_match[j] != current_gen[i+j-mid_num]
        end

    end

    ret
  end

  def self.max_rule_length
    7
  end
end
