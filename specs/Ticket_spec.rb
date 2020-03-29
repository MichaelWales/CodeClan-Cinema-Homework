require("minitest/autorun")
require('minitest/reporters')

require_relative('../models/Tickets')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TicketTest < MiniTest::Test



end
