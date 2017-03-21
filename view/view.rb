require 'observer'

class View
	def check_class_invariants

	end

	def update_pre_cond
	end

	def update_post_cond
	end

	def update
		update_pre_cond

		update_post_cond
	end
end