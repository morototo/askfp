class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, index: true, null: false
      t.string :name, default: ''
      t.text :self_introduction

      t.timestamps
    end
  end
end
