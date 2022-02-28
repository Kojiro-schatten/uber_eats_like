# README

restaurants 1 : N foods
foods       1 : 1 line_foods
line_foods  1 : 1 orders

# 出力されたrouts一覧から、'order'が含まれる一行のみを出力する
$ rails routes | grep order