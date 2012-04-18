class ItemQueriesController < ApplicationController

  def index
    @item_query = ItemQuery.new(params[:item_query])
    @item_query.search
  end
end
