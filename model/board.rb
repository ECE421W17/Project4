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

    def add_piece_pre_cond(col, piece)
        assert(0 <= col && col < @n_cols, 'Column number is invalid')
        assert(!column_full?(col), 'Column is full')
    end

    def add_piece_post_cond(col, piece)
        assert(piece_in_column?(col, piece), 'The piece was not added to column')
    end

    def add_piece(col, piece)
        add_piece_pre_cond(col, piece)
        # implement
        add_piece_post_cond(col, piece)
        check_class_invariants
    end

    def column_full?(col)
        # implement
    end

    def piece_in_column?(col, piece)
        # implement
    end

    def valid_columns_pre_cond
    end

    def valid_columns_post_cond
    end

    def valid_columns
        valid_columns_pre_cond
        # implement
        res = [2,3,4]
        valid_columns_post_cond
        res
    end
end