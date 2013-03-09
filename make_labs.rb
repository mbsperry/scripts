#!/usr/bin/env ruby

def make_cbc(v = {})
  top = format('    \%4s/', v[:hb])
  middle = format('%4s ---- %3s', v[:wbc], v[:platelet])
  bottom = format('    /%4s\\', v[:hct])
  puts top
  puts middle
  puts bottom
end

if $0 == __FILE__
  values = Hash.new { |hash, key|
    print "#{key.to_s}: "
    hash[key] = gets.chomp
  }
  make_cbc(values)
end

