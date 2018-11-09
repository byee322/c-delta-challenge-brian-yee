class AddMaxScoreToCreativeQualities < ActiveRecord::Migration[5.1]
  def change
    add_column :creative_qualities, :max_score, :integer, :default => 0
  end
end
