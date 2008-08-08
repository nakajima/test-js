module TestJS
  class Result
    include Output
    
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
      
      def errors
        list.map(&:test).select(&:errored)
      end
      
      def failures
        list.map(&:test).select(&:failed)
      end
      
      def list; @@list end
    end
    
    attr_reader :test
    
    def initialize(test)
      @test = Test.new(test)
    end
    
    # Prints a test's result, colorized by the color gem
    def display
      print_result case
      when @test.errored then 'E'.yellow
      when @test.passed  then '.'.green
      when @test.failed  then 'F'.red
      end
    end
    
    # Prints the error or failure message if the test didn't pass
    def report
      say "#{test_number}) #{'Error'.yellow}: #{test.name}\n- #{@test.errorMessage}" if @test.errored
      say "#{test_number}) #{'Failure'.red}: #{test.name}\n#{@test.failureReports.map { |s| "   - #{s}" }.join("\n")}" if @test.failed
    end
    
  private
    def test_number
      Result.list.index(self) + 1
    end
  
    def print_result(msg)
      $stdout.print(msg)
      $stdout.flush
    end
  end
end