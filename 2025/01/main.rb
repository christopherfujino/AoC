pos = 50
number_of_zeroes = 0

File.read('input.txt').split("\n").each do |cmd|
  direction = cmd.slice 0, 1
  distance = cmd[1..-1].to_i
  case direction
  when 'L'
    pos -= distance
  when 'R'
    pos += distance
  else
    raise "Unreachable: #{direction}"
  end
  pos = pos % 100
  puts "After #{cmd} position is now #{pos}"
  if pos == 0
    number_of_zeroes += 1
  end
end

puts "Number of zeroes: #{number_of_zeroes}"
