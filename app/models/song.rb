# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  key        :string(255)
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
end
