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
    len = self.to_match.length
    chars_to_match = []

    len.times do |c_len|
      # center rule around i
      c_len = c_len - len / 2
      num_to_add = c_len + i

      num_to_add  = current_gen.length + num_to_add if i < 0
      num_to_add = num_to_add - current_gen.length if num_to_add >= current_gen.length

      chars_to_match << current_gen[num_to_add]
    end

    ret = true

    chars_to_match.each_with_index do |ch, i|

      if to_match[i] != ch
        ret = false
        break
      end
    end

    ret
  end

  def update_neighborhood_size(new_size)
    current_size = to_match.length

    difference = (new_size - current_size).abs
    if new_size > current_size
      padding = "0" * (difference / 2)
      self.to_match = "#{padding}#{self.to_match}#{padding}"
    elsif current_size > new_size
      self.to_match = self.to_match[(difference / 2)...(current_size - difference / 2)]
    end

    save!
  end

  def self.max_rule_length
    7
  end
end
