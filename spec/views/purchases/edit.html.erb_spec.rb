require 'rails_helper'

RSpec.describe "purchases/edit", :type => :view do
  before(:each) do
    @purchase = assign(:purchase, Purchase.create!(
      :client => nil,
      :product => ""
    ))
  end

  it "renders the edit purchase form" do
    render

    assert_select "form[action=?][method=?]", purchase_path(@purchase), "post" do

      assert_select "input#purchase_client[name=?]", "purchase[client]"

      assert_select "input#purchase_product[name=?]", "purchase[product]"
    end
  end
end
