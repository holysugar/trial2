# coding: utf-8

module ItemDecorator
  include AutocrudAttrs

  autocrud_attrs_for :form, [:name, :price]
  autocrud_attrs_for :index, [:id, :enabled, :name, :price, :description_length]
  #autocrud_attrs_for :index, proc{ attribute_names.map(&:to_sym) }
  autocrud_attrs_for :show, proc{ attribute_names.map(&:to_sym) }


  def description_length
    description.length
  end

end

