n = gets.to_i

damage = {}
n.times do
  name = gets.chomp
  damage[name] = 0
end

m = gets.to_i
m.times do
  name, attack = gets.split(' ')
  damage[name] += attack.to_i
end

s = gets.chomp
puts damage[s]