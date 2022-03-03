module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create] #createの前に実行させる
    end

    def index
      line_foods = LineFood.active
      if line_foods.exists?
        render json: {
          line_food_ids: line_foods.map { |line_food| line_food.id },
          restaurant: line_foods[0].restaurant,
          count: line_foods.sum { |line_food| line_food[:count] },
          amount: line_foods.sum { |line_food| line_food.total_amount },
        }, status: :ok
      else 
        render json: {}, status: :no_content
      end
    end

    def create
      if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
        return render json: {
          # existing_restaurant: すでに作成されている他店舗の情報
          existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
          # new_restaurant: リクエストで作成しようとした新店舗の情報
          new_restaurant: Food.find(params[:food_id]).restaurant.name
          # not_acceptable -> 406
        }, status: :not_acceptable
      end

      # privateメソッドのset_line_food呼び出して、
      set_line_food(@ordered_food)

      # set_line_foodメソッド後に保存する
      if @line_food.save
        render json: {
          line_food: @line_food
        }, status: :created
      else
        render json: {}, status: :internal_server_error
      end
    end
    
    private

    # createでしか呼ばないため、set_food はprivateメソッドにする
    def set_food
      # インスタンス化することで、createアクションに渡す
      @ordered_food = Food.find(params[:food_id])
    end

    def set_line_food(ordered_food)
      if ordered_food.line_food.present?
        @line_food = ordered_food.line_food
        # 既に存在している場合、既存のline_foodインスタンスの情報を更新する
        @line_food.attributes = {
          count: ordered_food.line_food.count + params[:count],
          active: true
        }
      else
        # 新規に作成
        @line_food = ordered_food.build_line_food(
          count: params[:count],
          restaurant: ordered_food.restaurant,
          active: true
        )
      end
    end
  end
end