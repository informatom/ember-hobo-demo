class Contract < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    runtime   :integer
    term      :integer
    startdate :date
    timestamps
  end
  attr_accessible :runtime, :startdate, :term,  :created_at, :updated_at

  has_many :contractitems, dependent: :destroy, accessible: true

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