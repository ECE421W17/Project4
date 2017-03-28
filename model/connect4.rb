require_relative 'game'

class Connect4 < Game
    def categories
        [:Red, :Blue]
    end

    def player_patterns
        [
            [:Red, :Red, :Red, :Red],
            [:Blue, :Blue, :Blue, :Blue]
        ]
    end

    def default_n_rows
        6
    end

    def default_n_cols
        7
    end
end
