class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index

  def index
    @order = UserOrder.new
  end

  def create
    @order = UserOrder.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if user_signed_in? && current_user.id == @item.user.id
      redirect_to root_path
    elsif @item.order.present?
      redirect_to root_path
    end
  end

  def order_params
    params.require(:user_order).permit(:postal_code, :prefecture_id, :city_name, :address, :building_name, :phone_number)
          .merge(token: params[:token], item_id: params[:item_id], user_id: @item.user.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end
end
