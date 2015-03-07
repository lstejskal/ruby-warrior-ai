
class Player

  MAX_HEALTH      = 20
  CRITICAL_HEALTH = 5

  def initialize()
    @warrior = nil
    @enemy = nil
    @health_previous_turn ||= MAX_HEALTH
  end

  def play_turn(warrior)
    @warrior = warrior

    @spaces_forward = @warrior.look
    @space_forward = @spaces_forward.first

    case
    when enemy_ahead? && long_distance_enemy?
      @warrior.shoot!
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

  private

  def enemy_ahead?
    space = first_nonempty_space

    if space && space.enemy?
      @enemy = space
      true
    else
      false
    end
  end

  def long_distance_enemy?
    %w{ Wizard Archer }.include? @enemy.to_s
  end

  def first_nonempty_space
    @spaces_forward.each do |s| 
      next if s.empty?
      return s
    end

    nil
  end

end
