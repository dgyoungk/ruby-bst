require_relative 'tree.rb'


testing = Tree.new


testing.pretty_print
testing.insert(25)
puts %(\n)
testing.pretty_print
testing.insert(18)
puts %(\n)
testing.pretty_print

testing.delete(25)
puts %(\n)
testing.pretty_print
testing.delete(18)
puts %(\n)
testing.pretty_print
