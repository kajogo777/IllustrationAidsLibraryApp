
class UsersController < ApplicationController
before_action :authenticate_user!

	def ureserve
		itemid = params[:resitemid].to_i
		mo2tamar = params[:mo2tamar] == nil ? false : true

		@res = CheckOut.new
		@res.released = false
		@res.item_id = itemid
		@res.person_id = get_person.id
		@res.check_out_date = get_check_out_time
		@res.deadline_date = get_deadline_time(mo2tamar)

		@res.save

		@res
	end

	def urequest
		itemid = params[:reqitemid].to_i
		desc = params[:reqdesc]

		req = Request.new(person_id: get_person.id, 
						  item_id: itemid, 
						  description: desc)

		req.save
	end

	def check_outs
		@reserved = CheckOut.where(person_id: get_person.id, released: false)
		@checkedOut = CheckOut.where(person_id: get_person.id, released: true)
	end

	def cancel_check_out
		@checkid = params[:cancelCheckID].to_i
		CheckOut.destroy(@checkid)
	end

	private

	def get_deadline_time(mo2tamar)

		# t = DateTime.now.change({ hour: 0, min: 0, sec: 0 })
		# 	mag = 5-t.wday
		# 	dys = mag >= 0 ? mag : 7 + mag
		# 	t += dys.days
		# 	t += 7.days if mo2tamar

		# prsncheck = CheckOut.where("deadline_date > ? AND deadline_date < ? AND person_id = ?", t, t + 1.days, get_person.id).first

		# if prsncheck.blank?
			
		# 	n = 5*(CheckOut.where("deadline_date > ? ", t)
		# 				   .select(:person_id)
		# 				   .distinct.count)

		# 	t.change({ hour: 11, min: n, sec: 0 })

		# else

		# 	prsncheck.deadline_date

		# end

		t = if mo2tamar
			 	@res.check_out_date + 14.days
			else
				@res.check_out_date + 7.days
			end

	end

	def get_check_out_time

		# t = DateTime.now.change({ hour: 0, min: 0, sec: 0 })
		# 	mag = 5-t.wday
		# 	dys = mag >= 0 ? mag : 7 + mag
		# 	t += dys.days

		# prsncheck = CheckOut.where("check_out_date > ? AND person_id = ? AND released = ?", t, get_person.id, false).first

		# if prsncheck.blank?
			
		# 	n = 5*(CheckOut.where("check_out_date > ? ", t)
		# 				   .select(:person_id)
		# 				   .distinct.count)

		# 	t.change({ hour: 11, min: n, sec: 0 })

		# else

		# 	prsncheck.check_out_date

		# end

		t = DateTime.now
		mag = 5-t.wday
		if mag == 0
			t += 7.days if t.hour > 1
		else
			dys = mag > 0 ? mag : 7 + mag
			t += dys.days
		end
		
		t.change({ hour: 11, min: 0, sec: 0 })
		
	end

	def get_person
		current_user.person
	end
end
