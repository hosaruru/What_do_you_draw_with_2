a = gets.chomp.split(":")
tokei = a.map(&:to_i)
tokei[1] = tokei[1]+30


#もし[1]60以上なら、[0]に1を足す
if tokei[1] >= 60
    tokei[1] = tokei[1]-60
    tokei[0] = tokei[0]+1
end

if tokei[0] >= 24
    tokei[0] = tokei[0]-24
    
end

#もし0がぬけていたら足す
tokei = tokei.map(&:to_s)

if tokei[0].length == 1
    tokei[0] = "0"+tokei[0]
end
if tokei[1].length == 1
    tokei[1] = "0"+tokei[1]
end

puts "#{tokei[0]}:#{tokei[1]}"

