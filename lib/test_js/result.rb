module TestJS
  class Result
    # Container for all results
    @@list = []
    
    class << self
      # Instantiates new Result object, displays its result,
      # then adds it to the list
      def add(test)
        result = new(test)
        result.display
        @@list << result
      end
      
      def list; @@list end
    end # class << self
    
    def initialize(test)
      @test = test
    end
    
    # Prints a test's result, colorized by the color gem
    def display
      log case
      when @test.errored then 'E'.yellow
      when @test.passed  then '.'.green
      when @test.failed  then 'F'.red
      end
    end
  
  private
    def log(msg)
      $stdout.print(msg)
      $stdout.flush
    end
  end
end