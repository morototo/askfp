class CreateFpNgTimeFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :fp_ng_time_frames do |t|
      t.references :user, index: true, null: false
      t.references :time_frame, index: true, null: false
      t.boolean :is_weekday, null: false, default: true
      t.boolean :is_holiday, null: false, default: true

      t.timestamps
    end
  end
end
