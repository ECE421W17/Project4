require 'test/unit/assertions'

include Test::Unit::Assertions

class Board

    def check_class_invariants
        assert(@n_rows > 0, 'Number of rows must be greater than zero')
        assert(@n_cols > 0, 'Number of columns must be greater than zero')
    end

    def initialize_pre_cond(n_rows, n_cols)
        assert(n_rows > 0, 'Number of rows must be greater than zero')
        assert(n_cols > 0, 'Number of columns must be greater than zero')
    end

    def initialize_post_cond
    end

    def initialize(n_rows, n_cols)
        initialize_pre_cond(n_rows, n_cols)
        # implement
        @n_rows = n_rows
        @n_cols = n_cols
        initialize_post_cond
        check_class_invariants
    end

    def add_piece_pre_cond(col)
        assert(0 <= col && col < @n_cols)
    end

    def add_piece(col)

    end

end