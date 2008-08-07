module TestJS
  class Test
    def initialize(test)
      @test = test
    end
    
    def method_missing(m, *args)
      @test.send(m, *args)
    end
  end
end