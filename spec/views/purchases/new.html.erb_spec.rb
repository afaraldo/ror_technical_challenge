require 'rails_helper'

RSpec.describe "purchases/new", :type => :view do
  before(:each) do
    assign(:purchase, Purchase.new(
      :client => nil,
      :product => ""
    ))
  end

  it "renders new purchase form" do
    render

    assert_select "form[action=?][method=?]", purchases_path, "post" do

      assert_select "input#purchase_client[name=?]", "purchase[client]"

      assert_select "input#purchase_product[name=?]", "purchase[product]"
    end
  end
end
