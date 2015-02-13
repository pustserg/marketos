class OrdersController < ApplicationController

  def show
    respond_with (@order = Order.find(params[:id]))
  end

  def new
    respond_with @order = Order.new
  end

  def create
    @order = Order.create(order_params)
    if @order.save
      @order.add_items_from_cart(@current_cart)
      @current_cart.destroy
      redirect_to order_path(@order)
    else
      render 'new'
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone, :email, :address, :payment_type)
  end
end
