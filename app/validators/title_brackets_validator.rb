class TitleBracketsValidator
  attr_accessor :record

  def initialize(record)
    @record = record
  end

  BRACKETS_PAIRS = { "(" => ")", "{" => "}", "[" => "]" }.freeze

  def contains_empty_brackets?(title)
    remove_whitespaces = title.gsub!(/\s/, "")
    !!remove_whitespaces.match(/\{\}|\(\)|\[\]/)
  end

  def validate(record)
    title = record.title
    return if title.empty?

    if contains_empty_brackets?(title)
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
    BRACKETS_PAIRS.keys.include?(char)
  end

  def closing_bracket?(char)
    BRACKETS_PAIRS.values.include?(char)
  end

  def matching_brackets?(opening:, closing:)
    BRACKETS_PAIRS[opening] == closing
  end
end
