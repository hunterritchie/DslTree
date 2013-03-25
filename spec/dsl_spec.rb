
require File.dirname(__FILE__) + '/../lib/dsl_tree'
require  File.dirname(__FILE__) + '/test_dsl'

describe DslTree::DSL do
  
  before(:all) {
    @dsl = TestDsl.new
  }


  it 'create parent' do
    model = @dsl.build {
      parent('root', :nickname=>'topnode')
    }

    model.is_root?.should == true
    model.id.should == 'root'
    model.nickname.should == 'topnode'
  end

  it 'create parent with arguments' do
    model = @dsl.build {
      parent('root', :nickname=>'topnode', :a=>'a', :c=>'c')
    }

    model.is_root?.should == true
    model.id.should == 'root'
    model.nickname.should == 'topnode'
    model.a.should == 'a'
    model.b.nil?.should == true
  end

  it 'create parent, child, and grandchild' do
    model = @dsl.build {
      parent('node1', :nickname=>'one') {
        child('node2', :nickname=>'two') {
          grandchild('node3', :nickname=>'three')
        }
      }
    }

    @count = 0
    model.each { |node|
      @count += 1
      node.nickname.should == 'one' if 'node1' == node.id
      node.nickname.should == 'two' if 'node2' == node.id
      node.nickname.should == 'three' if 'node3' == node.id
    }
    @count.should == 3
  end

  it 'reopen child to change nickname' do
    model = @dsl.build {
      parent('node1', :nickname=>'one') {
        child('node2', :nickname=>'two') {
          grandchild('node3', :nickname=>'three')
        }
        child('node2', :nickname=>'two-half')
      }
    }

    @count = 0
    model.each { |node|
      @count += 1
      node.nickname.should == 'one' if 'node1' == node.id
      node.nickname.should == 'two-half' if 'node2' == node.id
      node.nickname.should == 'three' if 'node3' == node.id
    }
    @count.should == 3
  end

  it 'reopen parent to add value' do
    model = @dsl.build {
      parent('node1', :nickname=>'one') {
        child('node2', :nickname=>'two')
      }
      parent('node1', :a=>'b')
    }

    @count = 0
    model.each { |node|
      @count += 1
      node.nickname.should == 'one' if 'node1' == node.id
      node.nickname.should == 'two' if 'node2' == node.id
    }
    @count.should == 2

    model.a.should == 'b'
  end


end

