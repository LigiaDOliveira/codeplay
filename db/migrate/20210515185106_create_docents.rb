class CreateDocents < ActiveRecord::Migration[6.1]
  def change
    create_table :docents do |t|
      t.string :name
      t.string :email
      t.text :bio

      t.timestamps
    end
  end
end
