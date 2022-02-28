class LineFood < ApplicationRecord
  belongs_to :food
  belongs_to :restaurant
  belongs_to :order, optional: true #関連づけが任意
  validates :count, numericality: { greater_than: 0 }
  # 全てのLineFoodからwhereでactive:trueなものを一覧をARrelationの形で返す
  scope :active, -> { where(active: true) }
  # 特定の店舗IDではないもの一覧を返す
  #「他の店舗のLineFood」があるかどうか、をチェックする際にこのscopeを利用
  scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id) }

  # モデルに記述することで、さまざまな箇所から呼び出す。
  def total_amount
    food.price * count
  end
end