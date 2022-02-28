class Restaurant < ApplicationRecord
  has_many :foods
  has_many :line_foods, through: :foods
  validates :name, :fee, :time_required, precense: true
  validates :name, length: { maximum: 30 }
  validates :fee, numericality: { greater_than: 0 } # 手数料が0以上であることと制限
end