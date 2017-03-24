require 'test/unit/assertions'

include Test::Unit::Assertions

class Player

    attr_accessor :category, :winning_pattern, :number

    def check_class_invariants
        assert(@category, 'Player must have a category')
        assert(@winning_pattern, 'Player must have a winning pattern')
    end

    def initialize_pre_cond
    end

    def initialize_post_cond
    end

    def initialize(category, winning_pattern)
        initialize_pre_cond
        @category = category
        @winning_pattern = winning_pattern
        initialize_post_cond
        check_class_invariants
    end
end