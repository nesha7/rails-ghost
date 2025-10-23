class CreateScripts < ActiveRecord::Migration[7.1]
  def change
    create_table :scripts do |t|
      t.string :key
      t.jsonb :value, default: {}

      t.timestamps
    end
  end
end
