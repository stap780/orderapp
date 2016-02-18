class AddPostIdToIorders < ActiveRecord::Migration
  def change
  add_column :iorders, :post_id, :integer
  end
end
