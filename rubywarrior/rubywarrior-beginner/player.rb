
class Player

  MAX_HEALTH = 20

  def initialize()
    @health_previous_turn ||= MAX_HEALTH
  end

  def play_turn(warrior)
    @warrior = warrior

    @space_forward = @warrior.feel

    case
    when @space_forward.empty?
      if injured? and not taking_damage?
        @warrior.rest!
      else
        @warrior.walk!
      end
    when @space_forward.captive?
      @warrior.rescue!
    else
      @warrior.attack!
    end

    @health_previous_turn = @warrior.health
  end

  def injured?
    @warrior.health < MAX_HEALTH
  end

  def taking_damage?
    @warrior.health < @health_previous_turn
  end

  def retreat!
    @warrior.walk!(:backward)
  end

end
