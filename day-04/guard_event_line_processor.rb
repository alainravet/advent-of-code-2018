module GuardEvent
  class LineProcessor
    attr_reader :sleep_recorder

    def initialize(sleep_recorder)
      @sleep_recorder = sleep_recorder

      @current_guard_id = nil
    end

    def process_guard_event_line(event_line)
      minute, word_1, word_2 = parse_event_line(event_line)

      case word_1
      when 'Guard' # [50, "Guard", "#1789"]
        @current_guard_id = word_2.delete_prefix('#').to_i
      when 'falls' # [05, "falls", "asleep"]
        @fell_asleep_at = minute
      when 'wakes' # [25, "wakes", "up"]
        woke_up_at = minute
        sleep_recorder.record_time_asleep(@current_guard_id, from: @fell_asleep_at, to: woke_up_at - 1)
      end
    end

    private

      #                   INPUT                        ->         OUTPUT
      #  [1518-02-12 23:50] Guard #1789 begins shift   ->   [50, "Guard", "#1789"]
      #  [1518-02-13 00:05] falls asleep               ->   [05, "falls", "asleep"]
      #  [1518-02-13 00:09] wakes up                   ->   [25, "wakes", "up"]
      def parse_event_line(s)
        minute, word_1, word_2 = s.scan(/.+ ..:(..)\] (\S+) (\S+)/).flatten
        [minute.to_i, word_1, word_2]
      end
  end
end
