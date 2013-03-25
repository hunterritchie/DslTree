require File.dirname(__FILE__) + '/../lib/dsl_tree'

# create a dsl description, inherit from DslTree::DSL
class MyDSL < DslTree::DSL

  # definine initialize that populates the dsl description using the DslBuilder
  def initialize()
    @dsl = DslTree::DslBuilder.new{
      root->(parent, id, options={}){ Parent.new(parent, id, options) } {
        child->(parent, id, options={}){ Child.new(parent, id, options) }
      }
    }
  end

end

# objects in the model need to inherit from DslTree::ModelNode
class Parent < DslTree::ModelNode

  attr_accessor :nickname
  
  def initialize(parent, id, options={})
    @nickname = options[:nickname]
    super
  end
    
end

class Child < DslTree::ModelNode

  attr_accessor :nickname
  
  def initialize(parent, id, options={})
    @nickname = options[:nickname]
    super
  end
    
end

