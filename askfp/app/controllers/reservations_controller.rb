class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_is_guest, only: [:new, :create]

  def show
    @reservations = current_user.is_fp? ? Reservation.reserved(current_user.id) : current_user.reservations
  end

  def new
    @reservation = Reservation.new(new_params)
  end

  def create
    @reservation = Reservation.new(create_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to dashboard_index_path, notice: '予約が完了しました。' }
      else
        @reservation.errors.full_messages.each do |error|
          flash[:alert] = error
        end
        @reservation.attributes = create_params
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  def set_time
    @tiemes = business_time(Time.parse(params['select_date']))
    @tiemes = Reservation.get_free_reservation_time(@tiemes, params[:fp_id], Time.parse(params['select_date']))
    render json: @tiemes
  end

  private
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def create_params
      params.require(:reservation).permit(:fp_id, :guest_id, :start_at, :end_at, :reservation_date)
    end

    def new_params
      params.permit(:fp_id, :guest_id)
    end
end
