
class Player

  MAX_HEALTH = 20

  def initialize()
  end

  def play_turn(warrior)
    @warrior = warrior

    if @warrior.feel.empty?
      if @warrior.health < MAX_HEALTH
        @warrior.rest!
      else
        @warrior.walk!
      end
    else
      @warrior.attack!
    end
  end

end
