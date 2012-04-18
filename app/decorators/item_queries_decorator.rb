# coding: utf-8
module ItemQueriesDecorator
  def query_attrs
    attributes.keys.map(&:to_sym)
  end
end
