#!/usr/bin/env ruby

require "./calculator"

calculator = Calculator.new

loop do
  i = gets.chomp
  if i == "q"
    puts "goobye"
    exit 0
  else 
    begin
      e = calculator.input i
      puts "= #{e}" unless e.nil?
    rescue ArgumentError
      STDERR.puts "Invalid input '#{i}'"
    end
  end
end
