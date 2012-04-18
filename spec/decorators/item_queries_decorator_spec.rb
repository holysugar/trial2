# coding: utf-8
require 'spec_helper'

describe ItemQueriesDecorator do
  let(:item_queries) { ItemQueries.new.extend ItemQueriesDecorator }
  subject { item_queries }
  it { should be_a ItemQueries }
end
