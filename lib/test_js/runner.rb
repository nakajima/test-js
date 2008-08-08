module TestJS
  class Runner
    include Output
    
    def initialize(files, options={})
      @files = files
      @options = options
      @test_file = @files.map { |f| File.read(f) }.join("\n")
      @evaluator = Evaluator.new(options[:dom])
      run! unless options[:defer]
    end
    
    # Runs test file and reports results
    def run!
      say @file_path
      report_results Benchmark.measure { @evaluator << @test_file }
      report_errors
    end
    
    # Prints results to console, including failures and errors
    def report_results(t)
      say "Finished in #{t.real.to_s[0..6]} seconds"
      res = "#{Result.list.length} tests"
      color = :green
      res = "#{res} #{Result.failures.length} Failures" and color = :red unless Result.failures.empty?
      res = "#{res} #{Result.errors.length} Errors".yellow and color = :yellow unless Result.errors.empty?
      say res.send(color)
    end
    
    def report_errors
      Result.list.each(&:report)
    end
  end
end