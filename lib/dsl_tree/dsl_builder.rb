require File.dirname(__FILE__) + '/meta_model'
require File.dirname(__FILE__) + '/model'
require File.dirname(__FILE__) + '/stack'

module DslTree

  class DslBuilder

    attr_accessor :meta_model
    attr_accessor :model

    def initialize(&block)
      @root = {}
      @meta_model = MetaModel.new(@root, &block)
    end

    def build(&block)
      @model = Model.new(self, &block)
      @model.tree
    end

    def create_node(label, parent, id, options={})
      node = @meta_model.send(label.to_sym, parent, id, options)
      raise "Node type '#{label}' named '#{id}' is not of type DslTree::ModelNode" unless node.kind_of?(DslTree::ModelNode)
      node
    end

  end

end

