
module DslTree

  class Model

    attr_accessor :tree

    def initialize(dsl, &block)
      @dsl = dsl
      @root = dsl.meta_model.meta_model_root
      @parent = nil
      @context_stack = Stack.new()
      @context_stack.push(:meta_loc=>@root, :node=>nil)
      instance_eval(&block)
      @context_stack.pop()
    end

    def method_missing(label, *args, &block)
      context = @context_stack.peek()
      # look up the node type from the users prescribed dsl
      unless context[:meta_loc][:children].has_key?(label)
        raise("key missing for #{label}")
      else
        # create the model node
        if context[:node].nil?
          node = @dsl.create_node(label, nil, args[0], args[1])
        else
          node = @dsl.create_node(label, context[:node], args[0], args[1])
        end

        # add the model node to the tree
        if node.is_root?
          if @tree.nil?
            @tree = node
          else
            @tree.update(node)
          end
        elsif node.parent.respond_to?(:children) and !node.parent.children[node.id].nil?
            node.parent.children[node.id].update(node)
        else
          node.parent.add(node)
        end

        # recurse
        if block_given?
          @context_stack.push(:meta_loc=>context[:meta_loc][:children][label], :node=>node)
          instance_eval(&block)
          @context_stack.pop()
        end
      end
    end

  end

end

