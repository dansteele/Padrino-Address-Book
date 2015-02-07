class AddFavouriteTextEditorToTrainee < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.string :favourite_text_editor
    end
  end

  def self.down
    change_table :people do |t|
      t.remove :favourite_text_editor
    end
  end
end
