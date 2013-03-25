
require File.dirname(__FILE__) + '/../lib/dsl_tree/stack'

describe DslTree::Stack do

  before(:each) do
    @stack = DslTree::Stack.new()
  end

  it 'pushes object onto stack' do
    @stack.push('obj1')
    @stack.size.should == 1
  end

  it 'clears all objects from stack' do
    @stack.push('obj')
    @stack.size.should == 1
    @stack.clear()
    @stack.size.should == 0
  end

  it 'peeks at obj on stack' do
    @stack.push('obj')
    @stack.size.should == 1
    obj = @stack.peek() 
    obj.should == 'obj'
    @stack.size.should == 1
  end

  it 'pops obj off stack' do
    @stack.push('obj')
    @stack.size.should == 1
    obj = @stack.pop()
    obj.should == 'obj'
    @stack.size.should == 0
  end

end
