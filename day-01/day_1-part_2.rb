class DuplicateFrequencyFinder
  def initialize
    @current_frequency = 0
    @frequency_changes = File.readlines('frequency_changes.txt').map(&:to_i)

    @reached_frequencies = { @current_frequency => true }
  end

  def find
    val = iterate until val
    val
  end

  private

    def iterate
      @frequency_changes.each do |change|
        @current_frequency += change
        if @reached_frequencies.has_key?(@current_frequency)
          return @current_frequency
        else
          @reached_frequencies[@current_frequency] = true
        end
      end
      nil
    end
end

# -----

puts DuplicateFrequencyFinder.new.find # => 481
