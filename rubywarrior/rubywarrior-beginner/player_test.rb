
# bundle exec ruby -Irubywarrior/rubywarrior-beginner rubywarrior/rubywarrior-beginner/player_test.rb

require 'minitest/autorun'
require 'minitest/reporters'
require 'shoulda'
require 'mocha'

require 'ruby_warrior'
require 'player'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestPlayer < Minitest::Test

  context "Player" do

    context "Health" do 

      should "have max health set" do
        assert_equal 20, Player::MAX_HEALTH
      end

    end

  end

end
