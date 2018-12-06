module Polymer
  class Reactor
    def initialize(formula)
      @elements = formula.chars
    end

    def reactize
      char_1_idx     = 0
      char_1, char_2 = @elements.at(char_1_idx), @elements.at(char_1_idx + 1)
      while char_2 do
        if react?(char_1, char_2)
          @elements.delete_at(char_1_idx)
          @elements.delete_at(char_1_idx)
          char_1_idx     -= 1
          char_1, char_2 = @elements.at(char_1_idx), @elements.at(char_1_idx + 1)
        else
          char_1_idx += 1
          char_1     = char_2
          char_2     = @elements.at(char_1_idx + 1)
        end
      end
      @elements.join
    end

    private

      MATCH_DIFF = ('A'.ord - 'a'.ord).abs

      def react?(a, b)
        (a.ord - b.ord).abs == MATCH_DIFF
      end
  end
end
