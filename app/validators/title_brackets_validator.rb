class TitleBracketsValidator
  attr_accessor :title

  def initialize(title)
    @title = title
    @brackets_pairs = {'(' => ')', '{' => '}', '[' => ']'}
  end


  def validate(record)
    title = record.title
    if title.gsub(/\s/, '').match(/\{\}|\(\)|\[\]/)
      record.errors.add(:base, "Record contains empty brackets")
    end

    stack = []
    title.chars.each do |char|
      stack << char if opening_bracket?(char)
      if closing_bracket?(char)
        previous = stack.pop
        unless matching_brackets?(opening: previous, closing: char)
          record.errors.add(:base, "Record contains invalid brackets")
        end
      end
    end
    record.errors.add(:base, "Too few closing brackets in record") unless stack.empty?
  end

  private

  def opening_bracket?(char)
    @brackets_pairs.keys.include?(char)
  end

  def closing_bracket?(char)
    @brackets_pairs.values.include?(char)
  end

  def matching_brackets?(opening:, closing:)
    @brackets_pairs[opening] == closing
  end
end