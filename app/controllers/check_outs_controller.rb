class CheckOutsController < ApplicationController
  before_action :set_check_out, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @checkOutsR = CheckOut.where(released: true)
    @checkOutsNR = CheckOut.where(released: false)
  end

  def release
    checkid = params[:releaseCheckID]

    unless checkid == nil || checkid == ""
      @checkOutRls = CheckOut.find(checkid)
      @checkOutRls.released = true
      @checkOutRls.save
      @checkOutRls
    end
  end

  def check_item_in
    itmid = params[:itemID].to_i

    unless itmid == nil || itmid == 0

      checkout = CheckOut.find_by(item_id: itmid)

      if !checkout.blank? && checkout.released

        @late = (DateTime.now.beginning_of_day - checkout.deadline_date.to_datetime.beginning_of_day).to_i
        @fine = @late * 5

        checkin = CheckIn.new(item_id: checkout.item_id, 
                              person_id: checkout.person_id, 
                              on_deadline: (checkout.deadline_date <= DateTime.now)
                             )
        
        @checkoutid = checkout.id
        @loc = Item.find(itmid).location
       
        checkin.save
        CheckOut.destroy(@checkoutid)

      end

    end
  end

  private

    def remove_old_checkins
      CheckIn.where("created_at ?", DateTime.now - 9.months).destroy_all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_check_out
      @check_out = CheckOut.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def check_out_params
      params.require(:check_out).permit(:check_out_date, :deadline_date, :released, :item_id, :person_id)
    end
    
    def check_in_params
      params.require(:check_in).permit(:item_id, :person_id, :on_deadline)
    end
end
