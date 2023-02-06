class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :move_to_index, only: :index
  before_action :find_item, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
    return unless @item.user_id == current_user.id || !@item.purchase.nil?

    redirect_to root_path
  end

  def create
    @purchase_address = PurchaseAddress.new(address_params)
    if @purchase_address.valid?
      @purchase_address.save
      pay_item
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def address_params
    params.require(:purchase_address).permit(:postalcode, :prefecture_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: address_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    return if user_signed_in?

    redirect_to root_path
  end

  def find_item
    @item = Item.find(params[:item_id])
  end
end
