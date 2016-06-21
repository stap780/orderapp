class AddColumnPoIdToVariants < ActiveRecord::Migration
  def change
  add_column :variants, :product_option_id, :integer
  end
end
