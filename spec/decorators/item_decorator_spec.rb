# coding: utf-8
require 'spec_helper'

describe ItemDecorator do
  let(:item) { Item.new.extend ItemDecorator }
  subject { item }
  it { should be_a Item }
end
