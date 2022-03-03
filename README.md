# README

懐かしい復習

restaurants 1 : N foods
foods       1 : 1 line_foods
line_foods  1 : 1 orders

# SPAの文脈では、ControllerのことをAPIと呼ぶ

# 例外をあげたい時には ! (エクスクラメーションマーク)つきのメソッドを使う

```
tanaka.save # => false
tanaka.save! # => ActiveRecord::RecordInvalid: Validation failed: Name can't be blank
```

# 出力されたrouts一覧から、'order'が含まれる一行のみを出力する

```
$ rails routes | grep order
```
