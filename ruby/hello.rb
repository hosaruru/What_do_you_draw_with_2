# 1. ふたつのペアのりんごの数が異なる場合、りんごの数が多い方が偉い（この際、バナナの数は関係ない）。
# 2. りんごの数が同じである場合、バナナの数が多い方が偉い。
## 入力例1
# 2
# 1 3
# 2 2

## 出力例1
# 2 2
# 1 3

kazu = gets.to_i
set = readlines.map(&:chomp)
p set
puts set.sort.reverse
