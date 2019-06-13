class FpNgTimeFramesController < ApplicationController
  def index
    @fp_ng_time_frames = FpNgTimeFrame.mine(current_user)
    @timefarames = TimeFrame.all
  end

  def create
    imp_res = FpNgTimeFrame.upsert_fp_timeframe(create_params)
    respond_to do |format|
      if imp_res.num_inserts > 0
        format.html { redirect_to dashboard_index_path, notice: '予約不可時間を登録しました。' }
      else
        format.html { render :index, alert: '登録出来ませんでした。再度お試し下さい。' }
      end
    end
  end

  private
    def create_params
      params.permit(fp_ng_time_frames: [:id, :user_id, :is_weekday, :is_holiday, :time_frame_id])[:fp_ng_time_frames]
    end
end
