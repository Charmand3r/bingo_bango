class ParticipationNumberGenerator
  def self.generate
    buckets = [(1..9), (10..19), (20..29), (30..39), (40..49), (50..59), (60..69), (70..79), (80..90)].map(&:to_a)

    # FUCKIN BINGO!
    all_numbers = buckets.flat_map { |bucket| bucket.shuffle.first(3) }.sort
    selected_numbers = all_numbers.sample(15)

    all_numbers.map { |i| selected_numbers.include?(i) ? i : nil }
  end
end
