class FpNgTimeFrame < ApplicationRecord
  belongs_to :user
  belongs_to :time_frame, optional: true, required: true

  scope :mine, -> user_id{ where(user_id: user_id) }
  scope :only_holiday, -> { where(is_holiday: true) }
  scope :only_weekday, -> { where(is_weekday: true) }

  def self.upsert_fp_timeframe(upsert_params)
    fp_ng_time_frames = []
    upsert_params.each do |id, upsert_param|
      fp_ng_time_frames << FpNgTimeFrame.new(upsert_param)
    end
    FpNgTimeFrame.import fp_ng_time_frames, on_duplicate_key_update: [:is_weekday, :is_holiday]
  end
end
