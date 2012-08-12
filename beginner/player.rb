
class Player

  MAX_HEALTH = 20

  BAD_HEALTH = 12

  @@health = MAX_HEALTH

  @@direction = nil

  # REFACTOR to player instance 

  def play_turn(warrior)
    display_info(warrior)

    @@direction ||= :forward

    if warrior.feel(@@direction).wall?
      warrior.pivot!
    elsif captives_nearby?(warrior)
      warrior.rescue!(@@direction)
    elsif seriously_injured?(warrior)
      if taking_damage?(warrior)
        retreat!(warrior) # attack_or_advance!(warrior)
      elsif enemies_nearby?(warrior)
        retreat!(warrior)
      else
        warrior.rest!
      end
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

  def attack_or_advance!(warrior)
    warrior.feel(@@direction).empty? ? warrior.walk!(@@direction) : warrior.attack!(@@direction)
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

  def enemies_nearby?(warrior)
    warrior.feel(@@direction).enemy?
  end

  def captives_nearby?(warrior)
    warrior.feel(@@direction).captive?
  end

end
