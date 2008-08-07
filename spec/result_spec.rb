require File.join(File.dirname(__FILE__), 'spec_helper')

describe TestJS::Result do
  before(:each) do
    $stdout.stub!(:print) and $stdout.stub!(:flush)
    @runtime = setup_runtime
    @tc = @runtime.evaluate("new testJS.testCase('a name', function() { });")
    @result = TestJS::Result.new(@tc)
  end
  
  it "should description" do
    $stdout.should_receive(:print).with('.'.green)
    proc do
      TestJS::Result.add(@tc)
    end.should change(TestJS::Result.list, :length)
  end
  
  describe "#display()" do
    it "should display passing result to console" do
      $stdout.should_receive(:print).with('.'.green)
      @result.display
    end

    it "should display failing result to console" do
      $stdout.should_receive(:print).with('F'.red)
      @tc.failureReports.push :fail
      @result.display
    end

    it "should display errored result to console" do
      $stdout.should_receive(:print).with('E'.yellow)
      @tc.errorMessage = 'Whoops!'
      @result.display
    end
  end

end