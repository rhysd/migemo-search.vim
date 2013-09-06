## migemo-search.vim

migemo-search.vim は Vim の `/` や `?` での検索を損なうことなく migemo を組み込むことを目的としています．
migemo とは，ローマ字を入力として，そのローマ字を含む日本語にマッチする正規表現を生成するツールです．
`/` や `?` で検索する際にローマ字を入力すると自動的に検索ワードが migemo によって生成された正規表現に置き換えられ，ローマ字で日本語を検索することができるようになります．


###Requirements

[cmigemo](http://www.kaoriya.net/software/cmigemo/) が必要です． Debian 系の OS では `apt-get install cmigemo`，Mac では `brew install cmigemo` でインストール可能です．
また，オプショナルですが，[vimproc.vim](https://github.com/Shougo/vimproc.vim) がインストールされていると `system()` の代わりに `vimproc#system()` を使います．


###Usage

自分で `<CR>` にマッピングする必要があります．
`cmigemo` が無い環境では最初にプラグインを実行する際にエラーを吐くので，次のようにすることをおすすめします．

```vim
if executable('cmigemo')
    cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
endif
```

###License

MIT ライセンスです．

  Copyright (c) 2013 rhysd

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:
  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
