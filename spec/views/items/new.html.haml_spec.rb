require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :name => "MyString",
      :price => 1,
      :description => "MyText",
      :kind => 1,
      :enabled => false
    ).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_name", :name => "item[name]"
      assert_select "input#item_price", :name => "item[price]"
      assert_select "textarea#item_description", :name => "item[description]"
      assert_select "input#item_kind", :name => "item[kind]"
      assert_select "input#item_enabled", :name => "item[enabled]"
    end
  end
end
