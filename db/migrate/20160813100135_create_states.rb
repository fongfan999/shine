class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :code, size: 2, null: false
      t.string :name, null: false
    end
  end
end
