# 1. 持っている銀が多い方が財産が多い。
# 2. 持っている銀が同じなら、持っている金が多い方が財産が多い。

# 入力例1
# 2 二人いるよ
# 2 1　左が金、右が銀
# 1 2　左が金、右が銀

# 出力例1
# 1 2
# 2 1




people = gets.to_i
lines = readlines(chomp: true).map{|line| line.split(' ').map(&:to_i)}


lines = lines.sort {|a,b| a[1] <=> b[1]}.reverse


lines.each do |fruits|
    puts fruits.join(' ')
end




# people = gets.to_i
# lines = readlines(chomp: true).map{|line| line.split(' ').map(&:to_i)}
# lines = lines.reverse

# lines.sort.reverse

# lines = lines


# lines.each do |fruits|
#     puts fruits.join(' ')
# end
