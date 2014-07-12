class Consumableitem < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    position        :integer
    product_number  :string
    contract_type   :string
    product_line    :string
    description     :string
    amount          :integer
    theyield        :integer
    wholesale_price :decimal, :precision => 10, :scale => 2
    term            :integer
    consumption1    :integer
    consumption2    :integer
    consumption3    :integer
    consumption4    :integer
    consumption5    :integer
    consumption6    :integer
    balance6        :decimal, :precision => 10, :scale => 2
    timestamps
  end
  attr_accessible :position, :product_number, :product_line, :description, :amount,
                  :theyield, :wholesale_price, :term, :consumption1, :consumption2, :consumption3,
                  :consumption4, :consumption5, :consumption6, :balance6, :created_at, :updated_at,
                  :contract_type, :contractitem_id

  belongs_to :contractitem

  # --- Permissions --- #

  def create_permitted?
    true
  end

  def update_permitted?
    true
  end

  def destroy_permitted?
    true
  end

  def view_permitted?(field)
    true
  end
end