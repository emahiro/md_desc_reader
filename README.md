# md_desc_reader
markdownで見出し番号を指定するとその見出しに属する本文を取得する

```
# h1
## h2
### h3
description_1
```
上記のような構造のmdファイルを用意してコマンドを実行すると該当するdescriptionを取得する

```bash
$ bundle exec ruby app.rb 大見出し1 中見出し1 小見出し1
"description_1"
```
