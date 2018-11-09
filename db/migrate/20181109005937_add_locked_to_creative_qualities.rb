class AddLockedToCreativeQualities < ActiveRecord::Migration[5.1]
  def change
    add_column :creative_qualities, :locked, :boolean, :default => false
  end
end
