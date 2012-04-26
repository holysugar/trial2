# coding: utf-8
require 'spec_helper'

describe ItemQueryDecorator do
  let(:item_query) { ItemQuery.new.extend ItemQueryDecorator }
  subject { item_query }
  it { should be_a ItemQuery }
end
