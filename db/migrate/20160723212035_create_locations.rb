class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :lat
      t.string :lng
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
