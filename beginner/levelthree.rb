class Player
  def play_turn(warrior)
    # had to give the warrior time to recuperate before walking
    if warrior.feel.empty? && warrior.health <15
    warrior.rest!
  elsif warrior.feel.empty?
    warrior.walk!
  else
    warrior.attack!
  end
  end
end
