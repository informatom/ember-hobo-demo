class AllTablesAtOnce < ActiveRecord::Migration
  def self.up
    create_table :consumableitems do |t|
      t.integer  :position
      t.string   :product_number
      t.string   :contract_type
      t.string   :product_line
      t.string   :description
      t.integer  :amount
      t.integer  :theyield
      t.decimal  :wholesale_price, :precision => 10, :scale => 2
      t.integer  :term
      t.integer  :consumption1
      t.integer  :consumption2
      t.integer  :consumption3
      t.integer  :consumption4
      t.integer  :consumption5
      t.integer  :consumption6
      t.decimal  :balance6, :precision => 10, :scale => 2
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :contractitem_id
    end
    add_index :consumableitems, [:contractitem_id]

    create_table :contractitems do |t|
      t.integer  :position
      t.string   :product_number
      t.string   :description
      t.integer  :amount
      t.string   :unit
      t.integer  :volume
      t.decimal  :product_price, :precision => 10, :scale => 2
      t.decimal  :vat, :precision => 10, :scale => 2
      t.decimal  :value, :precision => 10, :scale => 2
      t.decimal  :discount_abs, :scale => 2, :precision => 10, :default => 0
      t.integer  :term
      t.date     :startdate
      t.integer  :volume_bw
      t.integer  :volume_color
      t.decimal  :marge, :precision => 10, :scale => 2
      t.decimal  :monitoring_rate, :precision => 10, :scale => 2
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :contracts do |t|
      t.integer  :runtime
      t.integer  :term
      t.date     :startdate
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :consumableitems
    drop_table :contractitems
    drop_table :contracts
  end
end
