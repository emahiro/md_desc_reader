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
  lidx = 0
  midx = 0
  sidx = 0

  lines.each_with_index do |line, idx|
    line = line.split("\s")
    case line[0]
    when "#" then
      midx = 0 # 中見出し index は初期化
      hash[idx] = {
          text: line[1],
          mark: LARGE,
          mark_index_num: mark_index_num(line[1]),
          l_index: lidx,
          m_index: midx,
          s_index: sidx
      }
      lidx += 1
    when "##" then
      sidx = 0 # 小見出し index は初期化
      hash[idx] = {
          text: line[1],
          mark: MIDDLE,
          mark_index_num: mark_index_num(line[1]),
          l_index: lidx,
          m_index: midx,
          s_index: sidx

      }
      midx += 1
    when "###" then
      hash[idx] = {
          text: line[1],
          mark: SMALL,
          mark_index_num: mark_index_num(line[1]),
          l_index: lidx,
          m_index: midx,
          s_index: sidx
      }
    else # 本  文(description)のとき
      hash[idx] = {
          text: line[0],
          mark: TEXT,
          mark_index_num: mark_index_num(line[0]),
          l_index: lidx,
          m_index: midx,
          s_index: sidx
      }
      sidx += 1
    end
  end
  hash
end

def main
  l_index = mark_index_num(ARGV[0])
  m_index = mark_index_num(ARGV[1])
  s_index = mark_index_num(ARGV[2])

  begin
    File.open("test_2.md") do |file|
      lines = file.read.split("\n").reject(&:empty?)
      hash = encode_md_to_hash(lines)
      hash.each do |h|
        p h[:text] if h[:mark] == TEXT && h[:l_index] == l_index && h[:m_index] == m_index && h[:s_index] == s_index - 1
      end
    end
  rescue => e
    p e.inspect
  end
end

# Main
main()