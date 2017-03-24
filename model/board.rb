require 'observer'
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

        @n_rows = n_rows
        @n_cols = n_cols
        @columns = @n_rows.times.map { Array.new(n_cols) }

        initialize_post_cond
        check_class_invariants
    end

    def positions
        @columns.transpose.reverse
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

        idx = @columns[col].index(nil)
        @columns[col][idx] = piece

        add_piece_post_cond(col, piece)
        check_class_invariants
    end

    def column_full?(col)
        !@columns[col].index(nil)
    end

    def piece_in_column?(col, piece)
        @columns[col].include? piece
    end

    def valid_columns_pre_cond
    end

    def valid_columns_post_cond
    end

    def valid_columns
        valid_columns_pre_cond

        res = @n_cols.times.select {|i| !column_full?(i)}

        valid_columns_post_cond
        res
    end

    def pattern_found_pre_cond(pattern)
        assert(pattern.length <= @n_rows, 'Pattern cannot be larger than the number of rows')
        assert(pattern.length <= @n_cols, 'Pattern cannot be larger than the number of columns')
    end

    def pattern_found_post_cond
    end

    def pattern_found(pattern)
        pattern_found_pre_cond(pattern)
        check_class_invariants

        # returns the positions of the pattern or nil
        pos = positions

        # find rows with the pattern
        pos.each_with_index do |row, row_index|
            pattern_position = find_linear_pattern(row, pattern)
            if pattern_position
                return pattern_position.map{|i| [row_index, i]}
            end
        end

        # find columns with the pattern
        pos.transpose.each_with_index do |col, col_index|
            pattern_position = find_linear_pattern(col, pattern)
            if pattern_position
                return pattern_position.map{|i| [i, col_index]}
            end
        end
        pattern_found_post_cond
    end

    def find_linear_pattern(line, pattern)
        pattern_index = line.each_cons(pattern.length).to_a.index do |cons|
            cons.zip(pattern).each {|piece, cat| piece && piece.category == cat}
        end
        pattern_index ? pattern.length.times.map{|i| pattern_index + i} : nil
    end
end