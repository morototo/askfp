class CreateTimeFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :time_frames do |t|
      t.string :start_at, null: false

      t.timestamps
    end
  end
end
