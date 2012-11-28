# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  key        :string(255)      default("CM")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Song < ActiveRecord::Base
  has_many :generations
  has_many :rules

  attr_accessible :key, :title

  after_create :initialize_first_generation

  def initialize_first_generation
    self.generations.create(current: "000000000000")
  end

  def step
    current_gen = self.generations.last.current
    new_gen = ""
    
    current_gen.length.times do |i|
      matched = false
      self.rules.each do |rule|
        if rule.match(current_gen, i)
          new_gen += rule.new_cell
          matched = true
          break
        end
      end

      if !matched
        new_gen += current_gen[i]
      end
    end

    self.generations.create(current: new_gen)
  end
end
