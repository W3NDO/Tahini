module Result
    class Result; end

    class Pass < Result
      attr_accessor :lhs, :rhs
    
      def initialize(lhs, rhs)
        # lhs is the expected result returned
        # rhs is the actual result returned
        if lhs != rhs or lhs.class != rhs.class
          raise ArgumentError, "Actual and expected values are not similar"
        end
        self.lhs = lhs
        self.rhs = rhs
      end
      
    end

    class Fail < Result
      attr_accessor :lhs, :rhs, :message
    
      def initialize(lhs, rhs, message: nil)
        # a new failure object will have a left hand side and a right hand side.
        # lhs is the expected result returned
        # rhs is the actual result returned
    
        if lhs == rhs
          raise ArgumentError, "a fail can not have a right hand side that is equal to a left hand side"
        end
    
        self.lhs = lhs
        self.rhs = rhs
        self.message = message
      end
      
        # add in other methods that would allow us to inspect the failure further probably
    end
      
end
