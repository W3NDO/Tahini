require_relative '../lib/basic_runner'

test_runner = Runner.new

test_runner.it("Returns True") do
  test_runner.to_be(true){ true }
end

test_runner.it("Returns false") do
  test_runner.expects do
    test_runner.to_be(false){ 1 < 0}
  end
end


