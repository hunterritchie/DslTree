
class TestDsl < DslTree::DSL
  def initialize()
    @dsl = DslTree::DslBuilder.new {
      parent->(parent, id, options={}){ Parent.new(parent, id, options)} {
        child->(parent, id, options={}){ Child.new(parent, id, options)} {
          grandchild->(parent, id, options={}){ Grandchild.new(parent, id, options)}
        }
      }
    }
  end
end

class Parent < DslTree::ModelNode
  attr_accessor :nickname
  attr_accessor :a
  attr_accessor :b
  def initialize(parent, id, options={})
    @nickname = options[:nickname]
    @a = options[:a]
    @b = options[:b]
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

class Grandchild < DslTree::ModelNode
  attr_accessor :nickname
  def initialize(parent, id, options={})
    @nickname = options[:nickname]
    super
  end
end


