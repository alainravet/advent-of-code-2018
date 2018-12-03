class OverlapDetector
  attr_reader :overlaps_count, :grid, :encoding_time

  def initialize
    @grid           = []
    @overlaps_count = 0
    @encoding_time  = 0
  end

  def encode_claims(claims)
    claims.each do |claim|
      encode_claim claim
    end
  end

  OVERLAP_SYMBOL = 'X'.freeze

  def encode_claim(claim)
    started_at = Time.now
    claim_id, offset_x, offset_y, width, height = claim.scan(/#(.+) @ (.+),(.+): (.+)x(.+)/).flatten.map(&:to_i)
    (offset_x..offset_x + width - 1).each do |x|
      (offset_y..offset_y + height - 1).each do |y|
        cell_value = cell(x, y)
        if cell_value.nil?
          set_cell(x, y, claim_id)
        elsif cell_value == OVERLAP_SYMBOL
          # overlap already detected in this cell
        else
          # first overlap in this cell
          set_cell(x, y, OVERLAP_SYMBOL)
          @overlaps_count += 1
        end
      end
    end
    @encoding_time += Time.now - started_at
  end

  def grid_to_s
    columns_count = grid.map { |row| row&.length || 0 }.max
    grid.map do |row|
      row ? row.map { |v| v || '.' }.join : ('.' * columns_count)
    end.join("\n")
  end

  private

    def set_cell(x, y, param)
      @grid[x][y] = param
    end

    def cell(x, y)
      @grid[x] ||= []
      @grid[x][y]
    end
end

