class AddTypeToPerson < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.string :type
    end
  end

  def self.down
    change_table :people do |t|
      t.remove :type
    end
  end
end
