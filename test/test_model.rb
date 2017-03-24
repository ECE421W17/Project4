#! /usr/bin/env ruby

require 'set'

require_relative '../model/board'
require_relative '../model/otto_n_toot'
require_relative '../model/connect4'

class TestModel

    def self.test_board
        n_rows = 8
        n_cols = 7
        b = Board.new(n_rows,n_cols)
        # Board goal:
        #          :F
        #          :F
        #          :F
        #          :F
        #       :T :F
        #       :O :F
        #    :O :T :F
        # :O :T :O :F

        b.add_piece(3, :F)
        b.add_piece(3, :F)
        b.add_piece(3, :F)
        b.add_piece(3, :F)
        b.add_piece(3, :F)
        b.add_piece(3, :F)
        b.add_piece(3, :F)
        b.add_piece(3, :F)

        b.add_piece(2, :O)
        b.add_piece(2, :T)
        b.add_piece(2, :O)
        b.add_piece(2, :T)

        b.add_piece(1, :T)
        b.add_piece(0, :O)
        b.add_piece(1, :O)

        pos = b.positions
        cols = b.valid_columns
        assert(cols == (n_cols.times.to_a - [3]), 'valid_columns doesn\'t work')

        pat = b.pattern_found([:T,:T,:T,:T])
        pat2 = b.pattern_found([:T,:O,:T,:O])
        pat3 = b.pattern_found([:O,:O,:O])
        pat4 = b.pattern_found([:O,:O])
        puts pos, cols, pat, pat2, pat3, pat4

        t = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9,10,11,12]
        ]
        expected = Set.new([[9],[5,10],[1,6,11],[2,7,12],[3,8],[4],[1],[2,5],[3,6,9],[4,7,10],[8,11],[12]])
        idx = b.diagonal_indices(3,4)
        result = Set.new(idx.map {|d| d.map {|i,j| t[i][j]}})
        assert(result == expected, 'diagonal calculation is incorrect')
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