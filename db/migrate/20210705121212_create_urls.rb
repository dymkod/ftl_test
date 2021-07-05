class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :code
      t.string :url
    end

    add_index :urls, :code, unique: true
  end
end
