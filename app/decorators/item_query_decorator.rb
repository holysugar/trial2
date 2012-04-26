# coding: utf-8
module ItemQueryDecorator
  def query_attrs
    attributes.keys.map(&:to_sym)
  end
end
