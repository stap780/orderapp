class ChangeColumnHomyproductsArtikuleType < ActiveRecord::Migration
  def up
        change_column :homyproducts, :artikul, :integer
    end

    def down
        change_column :homyproducts, :artikul, :string
    end
end
