class Player
  def play_turn(warrior)
    @best_health = 20
    @health ||= @best_health

    getting_hurt?(warrior)
    possible_action(warrior)
    check_health(warrior)
    end

  def getting_hurt?(warrior)
    @attacked = @health > warrior.health
  end

  def possible_action(warrior)
    if @attacked == true && warrior.feel.empty? == true
      warrior.walk!
    elsif @attacked == true && warrior.feel.empty? == false
      warrior.attack!
    elsif @attacked == false && warrior.feel.empty? == false && warrior.health == @best_health
        warrior.attack!
    elsif @attacked == false && warrior.feel.empty? == true && warrior.health == @best_health
        warrior.walk!
    elsif @attacked == false && warrior.health < @best_health
        warrior.rest!
    end
  end

  def check_health(warrior)
    @health = warrior.health
  end
end
