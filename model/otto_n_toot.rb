require_relative 'game'

class OttoNToot < Game

    def categories
        [:T, :O]
    end

    def player_patterns
        [
            [:O, :T, :T, :O],
            [:T, :O, :O, :T]
        ]
    end

    def default_n_rows
        7
    end

    def default_n_cols
        8
    end
end