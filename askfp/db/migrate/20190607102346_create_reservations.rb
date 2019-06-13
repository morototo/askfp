class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :fp, index: true
      t.references :guest, index: true
      t.string :start_at
      t.string :end_at
      t.date :reservation_date
      t.timestamps
    end
    add_foreign_key :reservations, :users, column: 'fp_id'
    add_foreign_key :reservations, :users, column: 'guest_id'
  end
end
