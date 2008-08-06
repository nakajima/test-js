module TestJS
  def self.printResult(test)
    log case
    when test.errored then 'E'.yellow
    when test.passed  then '.'.green
    when test.failed  then 'F'.red
    end
  end
  
  def self.log(msg)
    $stdout.print(msg)
    $stdout.flush
  end
end