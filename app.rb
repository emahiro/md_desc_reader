# MARK TYPE
LARGE = 0
MIDDLE = 1
SMALL = 2
TEXT = 3

# 見出しの末尾から見出しの順序を取得する
def mark_index_num(text)
  return text.split("").last.to_i
end

def encode_md_to_hash(lines)
  hash = []
  lines.each_with_index do |line, idx|
    line = line.split("\s")
    case line[0]
    when "#" then
      hash[idx] = {
          text: line[1],
          mark: LARGE,
          mark_index_num: mark_index_num(line[1]),
      }
    when "##" then
      hash[idx] = {
          text: line[1],
          mark: MIDDLE,
          mark_index_num: mark_index_num(line[1]),
      }
    when "###" then
      hash[idx] = {
          text: line[1],
          mark: SMALL,
          mark_index_num: mark_index_num(line[1]),
      }
    else # 本  文(description)のとき
      hash[idx] = {
          text: line[0],
          mark: TEXT,
          mark_index_num: mark_index_num(line[0])
      }
    end
  end
  hash
end

def main
  target_index_num = mark_index_num(ARGV[2]) || 0

  begin
    File.open("test_1.md") do |file|
      lines = file.read.split("\n").reject(&:empty?)
      hash = encode_md_to_hash(lines)
      hash.each do |h|
        p h[:text] if h[:mark] == TEXT && h[:mark_index_num] == target_index_num
      end
    end
  rescue => e
    p e.inspect
  end
end

# Main
main()