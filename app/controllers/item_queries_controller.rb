class ItemQueriesController < ApplicationController

  def index
    @item_query = ItemQuery.new(params[:item_query])
    @item_query.search
    logger.debug @item_query.errors.full_messages
    @items = @item_query.items.page(params[:page]).per(5)
  end
end
