
class Player

  MAX_HEALTH      = 20
  CRITICAL_HEALTH = 5

  def initialize()
    @health_previous_turn ||= MAX_HEALTH
  end

  def play_turn(warrior)
    @warrior = warrior

    @space_forward = @warrior.feel

    case
    when @space_forward.empty?
      if taking_damage?
        if seriously_injured?
          retreat!
        else
          @warrior.walk!
        end
      elsif injured?
        @warrior.rest!
      else
        @warrior.walk!
      end
    when @space_forward.wall?
      @warrior.pivot!
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

  def seriously_injured?
    @warrior.health < CRITICAL_HEALTH
  end

  def taking_damage?
    @warrior.health < @health_previous_turn
  end

  def retreat!
    @warrior.walk!(:backward)
  end

end
