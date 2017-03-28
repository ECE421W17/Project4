require 'test/unit/assertions'

require_relative '../model/game'

include Test::Unit::Assertions

class Controller

    def check_class_invariants
        assert_not_empty(@view, 'There must be a view')
        assert(@game, 'The controller must have a game')
    end

    def initialize(view, game, player = Player)
        @view = view
        @game = game
        check_class_invariants
        @game.add_observer(view)
    end

    def add_view(new_view)
        @game.add_observer(new_view)
        check_class_invariants
    end

	def notify_pre_cond
	end

	def notify_post_cond
	end

    # Views call this method in their event handlers
	def notify(player_number, column_number)
        @game.make_move(player_number, column_number)
	end
end
