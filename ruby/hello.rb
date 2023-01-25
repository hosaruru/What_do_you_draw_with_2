line = gets.chomp.split('')
nyuryoku = gets.chomp
kazu = line.length

kyoka = line.repeated_permutation(3).to_a
kyoka_len = kyoka.length
kyoka_list = []

q = 0
for i in 1..kyoka_len
kyoka_list[q] = 


kyoka[q][0]+kyoka[q][1]+kyoka[q][2]





q += 1
end
 p kyoka_list
line_len = line.length
l = 0
pass = ""
for i in 1..line_len
pass = pass + line[l]
l += 1
end


if kyoka_list.include?(nyuryoku) && !(nyuryoku == pass)
  puts "YES"
  else
  puts "NO"   
end

