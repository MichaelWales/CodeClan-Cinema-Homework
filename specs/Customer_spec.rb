require("minitest/autorun")
require('minitest/reporters')

require_relative('../models/Customers')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class CustomerTest < MiniTest::Test



end
