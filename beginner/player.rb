
class Player

  GOOD_HEALTH = 20

  BAD_HEALTH = 12

  def play_turn(warrior)
    display_info(warrior)

    if seriously_injured?(warrior)
      if enemies_nearby?(warrior)
        retreat!(warrior)
      else
        warrior.rest!
      end
    elsif warrior.feel.empty?
      if injured?(warrior)
        warrior.rest!
      else
        warrior.walk!
      end
    else
      warrior.attack!
    end
  end

  def display_info(warrior)
    puts "Health: %s" % warrior.health
  end

  def injured?(warrior)
    warrior.health < GOOD_HEALTH
  end

  def seriously_injured?(warrior)
    warrior.health <= BAD_HEALTH
  end

  def retreat!(warrior)
    warrior.walk!(:backward)
  end

  def enemies_nearby?(warrior)
    warrior.feel.enemy?
  end

end
