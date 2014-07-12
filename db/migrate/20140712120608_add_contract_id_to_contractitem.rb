class AddContractIdToContractitem < ActiveRecord::Migration
  def self.up
    add_column :contractitems, :contract_id, :integer

    add_index :contractitems, [:contract_id]
  end

  def self.down
    remove_column :contractitems, :contract_id

    remove_index :contractitems, :name => :index_contractitems_on_contract_id rescue ActiveRecord::StatementInvalid
  end
end
