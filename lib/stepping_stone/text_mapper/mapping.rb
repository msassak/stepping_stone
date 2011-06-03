require 'stepping_stone/pattern'

module SteppingStone
  module TextMapper
    class Mapping
      def self.build(dsl_args)
        from, to = dsl_args.shift
        new(from, to)
      end

      attr_accessor :from, :to

      def initialize(from, to)
        @from = from
        @to = to # MethodSignature.new(to) ???
        @pattern = Pattern.new(from)
      end

      def match(pattern)
        @pattern === pattern
      end

      def captures_from(str)
        Regexp.new(from).match(str).captures
      end

      def to_proc
        this = self
        Proc.new do
          send(this.to)
        end
      end
    end
  end
end
