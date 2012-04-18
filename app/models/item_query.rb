class ItemQuery
  include ActiveAttr::BasicModel
  include ActiveAttr::MassAssignmentSecurity
  include ActiveAttr::Logger
  include ActiveAttr::Attributes

  attribute :price
  attribute :price_op
  attribute :name
  attribute :kind
  # attr_accessible :title, :body

  attr_accessor :items

  validate do
    delegated_validate(Item, :price, :kind)
  end
  validates :price_op, :inclusion => { :in => %w(gt lt) }, :allow_blank => true

  def search
    # FIXME kaminari?
    @items = search_query.all
  rescue
    @items = []
  end

  def search_query
    query = Item.scoped
    query = query.where(name: name) if name.present?
    query = query.where(kind: kind) if kind.present?

    if price.present?
      case price_op
      when "gt"
        query = query.where("price > ?", price)
      when "lt"
        query = query.where("price < ?", price)
      else
        query = query.where(price: price)
      end
    end
    query
  end

  private

  def delegated_validate(klass, *attrs)
    inner = klass.new(attributes.symbolize_keys.slice(*attrs))
    if wrapped.invalid?
      attrs.each do |attr|
        if attributes[attr.to_s] && (error = wrapped.errors[attr]).present? # allow nil
          error.each do |e|
            self.errors.add attr, e
          end
        end
      end
    end
  end
end
