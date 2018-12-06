module Polymer
  class Reactor
    def collapse(formula)
      collapsed_elements = collapse_elements(formula.chars)
      collapsed_formula  = collapsed_elements.join
    end

    def remove_unit_type_and_collapse_elements(formula, unit_type_to_remove)
      removed_1, removed_2 = unit_type_to_remove.downcase, unit_type_to_remove.upcase # ex: 'a' and 'A'
      elements             = formula.chars
      elements.delete_if { |element| element == removed_1 || element == removed_2 }

      collapse_elements(elements)
    end

    def find_unit_type_to_remove_for_maximum_collapse(formula)
      removed_unit_types_and_collapsed_lengths = ('a'..'z').map do |base_to_remove|
        res = Polymer::Reactor.new.remove_unit_type_and_collapse_elements(formula, base_to_remove)
        [base_to_remove, res.length]
      end

      unit_type, collapsed_length = removed_unit_types_and_collapsed_lengths.sort_by(&:last).first
      [unit_type, collapsed_length]
    end

    private

      def collapse_elements(elements)
        char_1_idx     = 0
        char_1, char_2 = elements.at(char_1_idx), elements.at(char_1_idx + 1)
        while char_2 do
          if reactive_pair?(char_1, char_2)
            elements.delete_at(char_1_idx)
            elements.delete_at(char_1_idx)
            char_1_idx     -= 1
            char_1, char_2 = elements.at(char_1_idx), elements.at(char_1_idx + 1)
          else
            char_1_idx += 1
            char_1     = char_2
            char_2     = elements.at(char_1_idx + 1)
          end
        end
        elements
      end

      MATCH_DIFF = ('A'.ord - 'a'.ord).abs

      #   'a' and 'A' -> true
      #   'a' and 'C' -> false
      def reactive_pair?(a, b)
        (a.ord - b.ord).abs == MATCH_DIFF
      end
  end
end
