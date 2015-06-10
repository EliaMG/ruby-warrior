class Player

  def initialize
    @best_health = 20
    # using the or equals we saw in POODIR, sets health to best_health
    @health ||= @best_health
  end

  def play_turn(warrior)
    getting_hurt?(warrior)
    possible_move(warrior)
    check_health(warrior)
  end

  def getting_hurt?(warrior)
    # if health is declining, warrior is being attacked
    @attacked = @health > warrior.health
  end

  def possible_move(warrior)
    #rescues captive first if there
    if warrior.feel.captive? == true
      warrior.rescue!
    # moves forward if being attacked
    elsif @attacked == true && warrior.feel.empty? == true
      warrior.walk!
    # attack if being attacked and enemy is in next square
    elsif @attacked == true && warrior.feel.empty? == false
      warrior.attack!
    # keep attacking if enemy still there and recuperated
    elsif @attacked == false && warrior.feel.empty? == false && warrior.health == @best_health
        warrior.attack!
    # walk once fully recuperated and enemy vanquished
    elsif @attacked == false && warrior.feel.empty? == true && warrior.health == @best_health
        warrior.walk!
    # if not being attacked, rest to restore health score
    elsif @attacked == false && warrior.health < @best_health
        warrior.rest!
    end
  end

  def check_health(warrior)
    # check in order to be able to see if health declining
    @health = warrior.health
  end
end
