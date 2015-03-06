
class Player

  def initialize()
  end

  def play_turn(warrior)
    @warrior = warrior

    if @warrior.feel.empty?
      @warrior.walk!
    else
      @warrior.attack!
    end
  end

end
