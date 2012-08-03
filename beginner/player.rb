
class Player

  MAX_HEALTH = 20

  BAD_HEALTH = 12

  @@health = MAX_HEALTH

  # REFACTOR to player instance 

  def play_turn(warrior)
    display_info(warrior)

    if seriously_injured?(warrior)
      if taking_damage?(warrior)
        attack_or_advance!(warrior)
      elsif enemies_nearby?(warrior)
        warrior.retreat!
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
    warrior.feel.empty? ? warrior.walk! : warrior.attack!
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
    warrior.walk!(:backward)
  end

  def enemies_nearby?(warrior)
    warrior.feel.enemy?
  end

end
