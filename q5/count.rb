#!/usr/bin/env ruby
counts = Hash.new

# Count them
File.foreach("sample.log") do |line|
  ip = line.split[1]
  counts[ip] += 1 if counts[ip]
  counts[ip]  = 1 unless counts[ip]
end

# Print the output sorted by value
counts.sort_by { |k, v| -v }.each do |ip,count|
  puts "#{count} #{ip}"
end
