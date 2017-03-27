require 'test/unit/assertions'
require_relative 'player'

include Test::Unit::Assertions

class VirtualPlayer < Player
    def initialize(category, winning_pattern)
    	super(category, winning_pattern)
    end

    ##Algorithm for computerized player
    def makemove(board, game)

    	validColumn = board.valid_columns

    	if(validColumn.length == 0)
    		puts "no more available moves"
    	end

    	if(validColumn.length == 1)
    		#We have no choices
    		return validColumn[0]
    	end

    	#check is there a winning move
		validColumn.each do |i|
			board.add_piece(i, category)
			winning_positions = board.pattern_found(winning_pattern)
			board.remove_piece(i, category)
			if winning_positions
				return i
			end
		end

		player2 = nil
		game.players.each do |i|
			if i.category != this.category
				player2 = i
			end
		end

		#check is the move will lead to other player to win
		validColumn.each do |i|
			board.add_piece(i, category)
			vCol = board.valid_columns
			vCol.each do |j|
				board.add_piece(j, player2.category)
				winning_positions = board.pattern_found(player2.winning_pattern)
				board.remove_piece(j, player2.category)
				if !winning_positions
					board.remove_piece(i, category) 
					return i
				end
			end
		end
		return validColumn[0]
    end

end
