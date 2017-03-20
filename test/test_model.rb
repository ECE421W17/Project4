#! /usr/bin/env ruby

require_relative '../model/board'

class TestModel
    def self.test
        b = Board.new(8,7)
    end

end

TestModel.test