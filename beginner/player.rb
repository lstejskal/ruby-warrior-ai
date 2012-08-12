
class Player

  MAX_HEALTH = 20

  BAD_HEALTH = 12

  @@health = MAX_HEALTH

  @@direction = nil

  @@ahead = []

  # REFACTOR to player instance 

  def play_turn(warrior)
    display_info(warrior)

    @@direction ||= :forward

    @@ahead = warrior.look(@@direction)

    if warrior.feel(@@direction).wall?
      warrior.pivot!

    elsif captives_ahead?(warrior)
      rescue_or_advance!(warrior)

    elsif seriously_injured?(warrior)
      taking_damage?(warrior) ? retreat!(warrior) : warrior.rest!

    elsif injured?(warrior) and not taking_damage?(warrior)
      warrior.rest!

    else
      attack_or_advance!(warrior)

    end

    @@health += health_change(warrior)
  end

  def display_info(warrior)
    puts "Health: %s (%s)" % [ warrior.health, health_change(warrior, "display_as_string") ]
  end

  def rescue_or_advance!(warrior)
    warrior.feel(@@direction).empty? ? warrior.walk!(@@direction) : warrior.rescue!(@@direction)
  end

  def attack_or_advance!(warrior)
    if enemies_ahead?(warrior)
      warrior.shoot!(@@direction)
    elsif enemies_nearby?(warrior)
      warrior.attack!(@@direction)
    else
      warrior.walk!(@@direction)
    end
  end

  def injured?(warrior)
    warrior.health < MAX_HEALTH
  end

  def seriously_injured?(warrior)
    warrior.health <= BAD_HEALTH
  end

  # shows how health changed between turns
  # as_string - add "+" prefix to values > 0
  #
  def health_change(warrior, as_string = false)
    result = warrior.health - @@health

    if as_string
      "%s%s" % [ ("+" if result > 0), result ]
    else
      result
    end
  end

  def taking_damage?(warrior)
    health_change(warrior) < 0
  end

  def retreat!(warrior)
    warrior.walk!(@@direction == :forward ? :backward : :forward)
  end

  def nearest_occupied_space()
    @@ahead.each do |space| 
      return space if (! space.empty?) && (! space.wall?)
    end

    nil
  end

  # is there enemy up to 3 spaces ahead of warrior?
  def enemies_ahead?(warrior)
    nearest_occupied_space() && nearest_occupied_space().enemy?
  end

  # is there an enemy in front of warrior?
  def enemies_nearby?(warrior)
    warrior.feel(@@direction).enemy?
  end

  def captives_ahead?(warrior)
    nearest_occupied_space() && nearest_occupied_space().captive?
  end


end

# TODO should write tests, eventually (for epic mode)
