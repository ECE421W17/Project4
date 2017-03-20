require 'test/unit/assertions'

include Test::Unit::Assertions

class Piece

    attr_accessor :category

    def check_class_invariants
        assert(@category, 'A piece\'s category cannot be nil')
    end

    def initialize_pre_cond
    end

    def initialize_post_cond
    end

    def initialize(category)
        initialize_pre_cond
        @category = category
        initialize_post_cond
        check_class_invariants
    end

end