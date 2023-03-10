class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, only: :edit
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if @item.user != current_user || !@item.purchase.nil?
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if @item.user == current_user
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:product, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :delivery_time_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in?

    redirect_to action: :index
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
