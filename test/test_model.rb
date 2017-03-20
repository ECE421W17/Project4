#! /usr/bin/env ruby

require_relative '../model/board'
require_relative '../model/otto_n_toot'
require_relative '../model/connect4'

class TestModel

    def self.test_board
        b = Board.new(8,7)
    end

    def self.test_game
        ont = OttoNToot.new
        cfour = Connect4.new(7, 8, [:Colour2, :Colour1])
        ont.make_move(1, 3)
        cfour.make_move(2, 1)
    end

end

TestModel.test_board
TestModel.test_game