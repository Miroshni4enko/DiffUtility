require './lib/line'
require './lib/formatters/terminal'

class DiffLCS
  def initialize(file_path1, file_path2)
    @array1 = File.open(file_path1).readlines
    @array2 = File.open(file_path2).readlines
  end

  def compare(m = @array1.length, n = @array2.length)
    # if last character of array1 and array2 matches
    if m > 0 && n > 0 && @array1[m - 1] == @array2[n - 1]
      compare(m.dup - 1, n.dup - 1)
      build_line(@array1[m - 1], :unchanged)

    # current character of array2 is not present in array1
    elsif n > 0 && (m == 0 || lookup[m][n - 1] >= lookup[m - 1][n])
      compare(m.dup, n.dup - 1)
      build_line(@array2[n - 1], :insert)

    # current character of array1 is not present in array2
    elsif m > 0 && (n == 0 || lookup[m][n - 1] < lookup[m - 1][n])
      compare(m.dup - 1, n.dup)
      build_line(@array1[m - 1], :deleted)
    end
  end

  def lines
    @lines ||= []
  end

  private

  def build_line(value, state)
    lines << Line.new(value, state)
  end

  def lookup
    return @lookup unless @lookup.nil?

    @lookup = Array.new(@array1.length + 1) {Array.new(@array2.length + 1)}

    init_lookup(@lookup)
    build_lcs_matrix(@lookup)

    @lookup
  end

  def init_lookup(lookup)
    # first column of the lookup table will be all 0
    (0..@array1.length).each {|i| lookup[i][0] = 0}

    #  first row of the lookup table will be all 0
    (0..@array2.length).each {|i| lookup[0][i] = 0}
  end

  def build_lcs_matrix(lookup)
    # fill the lookup table in bottom-up manner
    (1..@array1.length).each do |i|
      (1..@array2.length).each do |j|
        #   if current character of array1 and array2 matches
        if @array1[i - 1] == @array2[j - 1]
          lookup[i][j] = lookup[i - 1][j - 1] + 1
          # else if current character of array1 and array2 don't match
        else
          lookup[i][j] = [lookup[i - 1][j], lookup[i][j - 1]].max
        end
      end
    end
  end
end
