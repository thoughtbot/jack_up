class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.timestamps
    end

    add_attachment :assets, :file
  end
end
