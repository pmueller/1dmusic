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
  belongs_to :user

  attr_accessible :key, :title

  after_create :initialize_first_generation
  after_create :initialize_base_rules

  def initialize_first_generation
    self.generations.create!(current: Generation.first_generation_string)
  end

  def initialize_base_rules
    self.rules.create(to_match: "0", new_cell: "0")
    self.rules.create(to_match: "1", new_cell: "1")
  end

  def step
    current_gen = self.generations.last.current
    new_gen = ""
    
    current_gen.length.times do |i|

      self.rules.long_first.each do |rule|
        if rule.match(current_gen, i)
          new_gen += rule.new_cell
          break
        end
      end

    end

    padding  ="0" * (Rule.max_rule_length/2) 
    self.generations.create(current: "#{padding}#{new_gen}#{padding}")
  end
end
