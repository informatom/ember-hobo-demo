class Contractitem < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    position        :integer, :required
    product_number  :string
    description     :string
    amount          :integer
    unit            :string
    volume          :integer
    product_price   :decimal, :precision => 10, :scale => 2
    vat             :decimal, :precision => 10, :scale => 2
    value           :decimal, :precision => 10, :scale => 2
    discount_abs    :decimal, :required, :scale => 2, :precision => 10, :default => 0
    term            :integer
    startdate       :date
    volume_bw       :integer
    volume_color    :integer
    marge           :decimal, :precision => 10, :scale => 2
    monitoring_rate :decimal, :precision => 10, :scale => 2
    timestamps
  end

  attr_accessible :position, :product_number, :description, :amount, :unit, :volume,
                  :product_price, :vat, :value, :discount_abs, :term, :startdate, :volume_bw, :volume_color,
                  :marge, :monitoring_rate, :created_at, :updated_at

  has_many :consumableitems

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