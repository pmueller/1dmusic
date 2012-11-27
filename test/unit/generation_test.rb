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

require 'test_helper'

class GenerationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
