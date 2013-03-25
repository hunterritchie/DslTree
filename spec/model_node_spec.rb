
require File.dirname(__FILE__) + '/../lib/dsl_tree/model_node'

describe DslTree::ModelNode do

  it 'create root node' do
    tree = DslTree::ModelNode.new(nil, 'root')
    tree.is_root?.should == true
  end

  it 'check root node has correct id' do
    tree = DslTree::ModelNode.new(nil, 'root')
    node = tree.root
    node.id.should == 'root'
  end

  it 'add child' do
    tree = DslTree::ModelNode.new(nil, 'root')
    child = DslTree::ModelNode.new(tree, 'child1')
    tree.add(child)
    node = tree.root
    node.children.size.should == 1
  end

  it 'delete child' do
    tree = DslTree::ModelNode.new(nil, 'root')
    child = DslTree::ModelNode.new(tree, 'child1')
    tree.add(child)
    tree.del(child)
    node = tree.root
    node.children.size.should == 0
  end

  it 'have correct number of children' do
    tree = DslTree::ModelNode.new(nil, 'root')
    child = DslTree::ModelNode.new(tree, 'child1')
    tree.add(child)
    child = DslTree::ModelNode.new(tree, 'child2')
    tree.add(child)
    node = tree.root
    node.children.size.should == 2
  end

  it 'find child' do
    tree = DslTree::ModelNode.new(nil, 'root')
    child = DslTree::ModelNode.new(tree, 'child1')
    tree.add(child)
    root_node = tree.root
    child_node = root_node.children['child1']
    child_node.id.should == 'child1'
  end

  it 'see child is not root' do
    tree = DslTree::ModelNode.new(nil, 'root')
    child = DslTree::ModelNode.new(tree, 'child1')
    tree.add(child)
    root_node = tree.root
    child_node = root_node.children['child1']
    child_node.is_root?.should == false
  end

  it 'find root from child' do
    tree = DslTree::ModelNode.new(nil, 'root')
    child = DslTree::ModelNode.new(tree, 'child1')
    tree.add(child)
    root_node = tree.root
    child_node = root_node.children['child1']
    root = child_node.root
    root.is_root?.should == true
  end

  it 'do depth first traversal' do
    tree = DslTree::ModelNode.new(nil, 'root')
    child = DslTree::ModelNode.new(tree, 'child1')
    tree.add(child)
    grandchild = DslTree::ModelNode.new(child, 'grandchild1')
    child.add(grandchild)
    child = DslTree::ModelNode.new(tree, 'child2')
    tree.add(child)

    names = []
    tree.each { |node| names << node.id }
    names.should == ["root", "child1", "grandchild1", "child2"]
  end

  it 'do breadth first traversal' do
    tree = DslTree::ModelNode.new(nil, 'root')
    child = DslTree::ModelNode.new(tree, 'child1')
    tree.add(child)
    grandchild = DslTree::ModelNode.new(child, 'grandchild1')
    child.add(grandchild)
    child = DslTree::ModelNode.new(tree, 'child2')
    tree.add(child)

    names = []
    tree.breadth_first_each { |node| names << node.id }
    names.should == ["root", "child1", "child2", "grandchild1"]
  end




end

