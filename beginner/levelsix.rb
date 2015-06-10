class Player

  def initialize
    @best_health = 20
    # using the or equals we saw in POODIR, sets health to best_health
    @health ||= @best_health
  end


  def play_turn(warrior)
    getting_hurt?(warrior)
    possible_action(warrior)
    check_health(warrior)
  end

  def getting_hurt?(warrior)
    # if health is declining, warrior is being attacked
    @attacked = @health > warrior.health
  end

  def possible_action(warrior)
    # walks backward if hasn't rescued captive yet
    if warrior.feel(:backward).empty? == true && @rescue_captive != 1
      warrior.walk!(:backward)
    # rescue the captive, increment count so doesn't get stuck in walk backward loop
    elsif warrior.feel(:backward).empty? == false
      warrior.rescue!(:backward)
      @rescue_captive = 1
    else
      # retreats out of range of archer if health too low
      if @attacked == true && warrior.feel.empty? == true
        if warrior.health < 10
          warrior.walk!(:backward)
        else
          warrior.walk!
        end
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
  end

  def check_health(warrior)
    # check in order to be able to see if health declining
    @health = warrior.health
  end
end
