require 'test/unit/assertions'

require_relative 'player'
require_relative 'board'
require_relative 'piece'
require_relative 'victory'

include Test::Unit::Assertions

class Game

    def categories
        []
    end

    def player_patterns
        []
    end

    def default_n_rows
        0
    end

    def default_n_cols
        0
    end

    def check_class_invariants
        assert(@board, 'A game must have a board')
        assert(@players && !@players.empty?, 'A game must have players')
    end

    def initialize_pre_cond(player_categories)
        player_categories.each_with_index do |c, i|
            assert(categories.include?(c), "The category for player #{i} is not valid")
        end
    end

    def initialize_post_cond
        assert(player_patterns.length == @players.length, 'Wrong number of players')
        @players.zip(player_patterns).each do |player, pattern|
            assert(player.winning_pattern == pattern, 'Player 1 must have the right winning pattern')
        end
    end

    def initialize(n_rows = default_n_rows, n_cols = default_n_cols, player_categories = categories)
        initialize_pre_cond(player_categories)
        @victory = nil
        @board = Board.new(n_rows, n_cols)
        @players = player_categories.zip(player_patterns).map do |cat, pattern|
            Player.new(cat, pattern)
        end
        initialize_post_cond
        check_class_invariants
    end

    def make_move_pre_cond(player_number, col)
        index = player_number - 1
        assert(0 <= index && index < @players.length, "There is no player #{player_number}")
        assert(@board.valid_columns.include?(col), "Column #{col} is not valid")
    end

    def make_move_post_cond
    end

    def make_move(player_number, col)
        make_move_pre_cond(player_number, col)
        # implement
        player = @players[player_number - 1]
        piece = Piece.new(player.category)
        @board.add_piece(col, piece)
        make_move_post_cond
        winner
    end

    def winner
        # Determine if any player has won (its winning condition is met)
        # set the Victory object accordingly
    end

end