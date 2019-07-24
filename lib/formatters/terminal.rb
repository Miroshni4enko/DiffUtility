require 'colorize'
require './lib/formatters/text'

module Formatters
  class Terminal < Text
    def format_deleted(line, position)
      super.colorize(:blue)
    end

    def format_insert(line, position)
      super.colorize(:green)
    end

    def format_changed(line, position)
      super.colorize(:red)
    end
  end
end
