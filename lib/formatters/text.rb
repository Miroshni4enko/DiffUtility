module Formatters
  class Text
    def initialize(lines)
      @lines = lines
      @output = ''
    end

    def format
      @lines.to_enum.with_index(1).each do |line, index|
        display send("format_#{line.state}", line, index)
      end

      @output
    end

    def display(value)
      @output << value.tr("\n", '') + "\n"
    end

    def format_deleted(line, position)
      "#{position}. - #{line.value}"
    end

    def format_insert(line, position)
      "#{position}. + #{line.value}"
    end

    def format_changed(line, position)
      "#{position}. * #{line.value}"
    end

    def format_unchanged(line, position)
      "#{position}.   #{line.value}"
    end
  end
end
