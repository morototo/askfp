class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :fp, index: true, null: false
      t.references :guest, index: true, null: false
      t.string :start_at, null: false
      t.string :end_at, null: false
      t.date :reservation_date, null: false
      t.timestamps
    end
    add_foreign_key :reservations, :users, column: 'fp_id'
    add_foreign_key :reservations, :users, column: 'guest_id'
  end
end
