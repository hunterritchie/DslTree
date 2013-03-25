
module DslTree

  # basic stack using a hash
  class Stack

    def initialize()
      @stack = {}
      @index = -1
    end

    def size()
      @stack.size
    end

    def push(obj)
      @index += 1
      @stack[@index] = obj
    end

    def pop()
      obj = @stack.delete(@index)
      @index -=1
      obj
    end

    def peek()
      @stack[@index]
    end

    def clear()
      @stack.clear()
      @index = -1
    end

  end

end


