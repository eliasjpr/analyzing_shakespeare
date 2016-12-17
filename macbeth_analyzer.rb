#!/usr/bin/ruby
require './lib/play_analyzer'

play = PlayAnalyzer.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
play.analyze
play.print_all
