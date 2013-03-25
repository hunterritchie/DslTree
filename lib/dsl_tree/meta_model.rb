
module DslTree

  class MetaModel

    def initialize(root, &block)
      root[:children] ||= {}
      @root = root
      @parent = root
      @current = @root[:children]
      instance_eval(&block)
    end
    
    def method_missing(label, *args, &block)
      label = label.to_sym
      my_arg = args[0]
      self.class.send(:define_method, label, &args[0])
      children = {}
      @current[label] = {:name=>label, :children=>children}

      # ancestor and context are used to save the current state, since the next instance_eval may recurse
      ancestor = @parent
      @parent = @current[label]

      context = @current
      @current = children

      instance_eval(&block) if block_given?

      @current = context
      @parent = ancestor
    end

    def meta_model_root
      @root
    end

  end

end

