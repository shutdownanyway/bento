class CartsController < ApplicationController
  def show
     @line_items = current_order.line_items
     @categories = Category.all
  end

  # def update
  #   @order = current_order
  #   @line_item = @order.line_items.find(params[:id])
  #   @line_item.update_attributes(line_item_params)
  #   @line_items = @order.line_items
  #   redirect_back(fallback_location: root_path)
  # end
  #
  # private
  #   def line_item_params
  #     params.require(:line_item).permit(:quantity, :product_id)
  #   end
end
