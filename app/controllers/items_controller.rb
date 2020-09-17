class ItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @user = User.find(params[:user_id])
    @item = @user.items.new(item_params)
    @item.save
  end

  private

  def item_params
    params.require(:item).permit(
      :goods, :details, :category, :status, :shipping_fee_burden, :shipping_area, :days_to_ship, :price, \
      :image).merge(user_id: current_user.id)
  end
end
