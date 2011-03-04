class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :collection
      t.string :value
      t.integer :number
      
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
