#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/my_dsl'

# create model tree from custom dsl
model = MyDSL.new.build { 
  root('my_root', :nickname=>"topper") {
    child('my_child1', :nickname=>"uno")
    child('my_child2', :nickname=>"dos")
  }
}

# basic navigation of object in the model
puts("model = #{model}")
puts("model.id = #{model.id}")
puts("model.is_root? = #{model.is_root?}")
puts("model.nickname = #{model.nickname}")
model.children.each { |id, node| puts("childnode = #{node.id}"); puts("child.nickname = #{node.nickname}") }


