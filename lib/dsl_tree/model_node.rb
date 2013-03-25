
module DslTree

  # the super for objects in the model so that it can be structured as a tree
  class ModelNode

    attr_accessor :parent
    attr_accessor :id
    attr_accessor :options

    def initialize(parent, id, options={})
      @id = id
      @parent = parent
      @children = {}
      @options = options
    end

    def root
      root = self
      while !root.is_root?
        root = root.parent
      end
      root
    end

    def is_root?
      @parent == nil
    end

    def add(child)
      @children[child.id] = child
      child.parent = self

      @children[child.id]
    end

    def del(child)
      @children.delete(child.id)
    end

    def children
      if block_given?
        @children.each { |child| yield child }
      else
        @children
      end
    end

    def update(node)
      node.options.each { |key, val|
        send("#{key}=", val) if respond_to?("#{key}=".to_sym)
      }
    end

    def children=(child_hash)
      @children = child_hash
    end

    def each(&block)
      yield self
      children { |id, child| child.each(&block) }
    end

    def breadth_first_each(&block)
      nodes = [self]
      until nodes.empty?
        next_node = nodes.shift
        yield next_node
        next_node.children { |id, child| nodes.push child }
      end
    end

  end

end

