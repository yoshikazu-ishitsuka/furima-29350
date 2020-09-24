class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    # binding.pry
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if  user_signed_in? && current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order).permit(:token).merge(user_id: current_user.id, item_id: @item.id)
    # params.require(:order).permit(:user_id, :item_id, :token)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      card: order_params[:token],
      currency:'jpy'
    )
  end

end
