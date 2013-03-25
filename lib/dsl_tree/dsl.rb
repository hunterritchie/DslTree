require File.dirname(__FILE__) + '/dsl_builder'

module DslTree

  class DSL

    attr_accessor :dsl
    
    def build(&block)
      @dsl.build(&block)
    end

  end

end

