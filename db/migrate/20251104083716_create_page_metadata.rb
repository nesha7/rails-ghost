class CreatePageMetadata < ActiveRecord::Migration[7.1]
  def change
    create_table :page_metadata do |t|
      t.string :slug
      t.string :meta_title

      t.timestamps
    end
  end
end