class OverlapDetector
  attr_reader :overlapsed_cells_count, :grid, :successful_claims, :encoding_time

  def initialize
    @grid                   = []
    @successful_claims      = []
    @overlapsed_cells_count = 0

    @encoding_time = 0
  end

  def encode_claims(claims)
    started_at = Time.now
    Array(claims).each do |claim|
      encode_claim claim
    end
    @encoding_time += Time.now - started_at
  end

  def grid_to_s
    longest_row_length = grid.map { |row| row&.length || 0 }.max
    grid.map { |row|
      row ? row.map { |v| v || '.'.freeze }.join : ('.' * longest_row_length)
    }.join("\n")
  end

  private

    OVERLAP_SYMBOL = 'X'.freeze

    def encode_claim(claim)

      claim_id, offset_x, offset_y, width, height = parse_claim(claim)

      overlap_detected_for_this_claim = false
      (offset_x..offset_x + width - 1).each do |x|
        (offset_y..offset_y + height - 1).each do |y|
          cell_value = cell(x, y)
          if cell_value.nil?
            set_cell(x, y, claim_id)
          else
            overlap_detected_for_this_claim = true
            if cell_value == OVERLAP_SYMBOL
              # overlap already detected in this cell
            else
              # first overlap in this cell
              @overlapsed_cells_count     += 1
              first_claimor_for_this_cell = cell_value
              @successful_claims.delete(first_claimor_for_this_cell)
              set_cell(x, y, OVERLAP_SYMBOL)
            end
          end
        end
      end
      @successful_claims << claim_id unless overlap_detected_for_this_claim
    end

    # input:  '#1 @ 2,3: 4x5',
    # output: [1, 2, 3, 4, 5]
    def parse_claim(claim)
      claim.scan(/#(.+) @ (.+),(.+): (.+)x(.+)/).flatten.map(&:to_i)
    end

    def set_cell(x, y, param)
      @grid[x][y] = param
    end

    def cell(x, y)
      @grid[x] ||= []
      @grid[x][y]
    end
end

