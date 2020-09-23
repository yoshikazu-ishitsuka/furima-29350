class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index]
  before_action :move_to_index

  def index
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

end
