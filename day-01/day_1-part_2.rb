class DuplicateFrequencyFinder
  def initialize
    @current_frequency   = 0
    @reached_frequencies = { @current_frequency => true }
  end

  def find_duplicate
    frequency_reached_twice = apply_frequency_changes until frequency_reached_twice
    frequency_reached_twice
  end

  private

    def frequency_changes
      File.readlines('frequency_changes.txt').map(&:to_i)
    end

    def apply_frequency_changes
      frequency_changes.each do |frequency_change|
        @current_frequency               += frequency_change
        frequency_was_previously_reached = @reached_frequencies.has_key?(@current_frequency)
        if frequency_was_previously_reached
          return @current_frequency
        else
          @reached_frequencies[@current_frequency] = true
        end
      end
      nil
    end
end

# -----

puts DuplicateFrequencyFinder.new.find_duplicate # => 481
