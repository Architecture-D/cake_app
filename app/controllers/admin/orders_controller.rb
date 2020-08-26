class Admin::OrdersController < ApplicationController
  def index
  	@orders = Order.page(params[:page]).reverse_order
  end

  def show
  	@order = Order.find(params[:id])
    @product = @order.order_products
  end

  def update
  	order = Order.find(params[:id])
  	if order.update(order_params)
      if params[:order][:status] == "入金確認"
        # ここにif文で書くことでupdate(更新ボタン押された)されたorderの情報が来る。
        # 更新ボタン押したときのターミナルでのParametersが"order"=>{"status"=>"入金確認"}なっている。
        # だから== "入金確認"と数字ではなく、普通に日本語で打った。
        order.order_products.update_all(make_status:"製作待ち")
        # updateだけだと一つしか更新できない。注文ステータス一つ更新すると、
        # 製作ステータス全てを更新したいのでupdate_allを使う。
        # update_allはrailsのdefaultに入ってるから定義する必要なし。
      end
      # 条件分岐 ステ-タスのカラム内容の照らし合わせ
      #   例 カラムがどんなときに変更するか
      #    ここで別のテーブルもupdateができること
  	   redirect_to admin_order_path(order)
  	else
  		render "index"
  	end
    # if params[:order][:status] == "入金確認"
    #     order.order_products.update_all(make_status:"製作待ち")
    # end
    # 上のようにここにif文があるとupdateされたorderの情報ではなく、
    # order = Order.find(params[:id])のorder情報が来てしまう可能性あり。

  end


 private
 def order_params
 	params.require(:order).permit(:status)
 end
end
