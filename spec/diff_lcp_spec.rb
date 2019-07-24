require "./lib/diff_lcs"

describe DiffLCS do
  describe "#diff" do
    context 'without changed lines' do
      it 'returns diff between files' do
        file_path1 ='./spec/fixtures/files/file1.txt'
        file_path2 ='./spec/fixtures/files/file2.txt'
        diff_lcs = DiffLCS.new(file_path1, file_path2)

        diff_lcs.compare

        expect(Formatters::Text.new(diff_lcs.lines).format).to eq diff_lines
      end

      def diff_lines
        <<-LINES
1. - Some
2. - Simple
3. + Another
4.   Text
5.   File
6. + With
7. + Additional
8. + Lines
        LINES
      end
    end
  end
end
