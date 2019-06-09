class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new(new_params)
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(create_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to dashboard_index_path, notice: '予約が完了しました。' }
      else
        format.html { render :new, alert: '予約出来ませんでした。再度お試し下さい。' }
      end
    end
  end

  def set_time
    @tiemes = business_time(Time.parse(params['select_date']))
    @tiemes = Reservation.get_free_reservation_time(@tiemes, params[:fp_id], Time.parse(params['select_date']))
    render json: @tiemes
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_params
      params.require(:reservation).permit(:fp_id, :guest_id, :start_at, :end_at, :reservation_date)
    end

    def new_params
      params.permit(:fp_id, :guest_id)
    end
end
