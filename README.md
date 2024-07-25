# text-ameba

## 利用場面

それぞれの文字列に対してシングルクオーテーションを付け、カンマを行末に追加したい場合

## 例

before
- aaaa
- bbbb
- cccc

after
- 'aaaa',
- 'bbbb',
- 'cccc'

## コード

```
# 起動
$ ameba
```

```
# 以下を入力後、改行して Ctrl + D
aaaa
bbbb
cccc
```

```
# 結果が出力される
'aaaa',
'bbbb',
'cccc'
```
