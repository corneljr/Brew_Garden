class ChargesController < ApplicationController
	before_action :require_login, only: [:create]

	def create
		@email = params['email']
		@project = Project.find(params[:project_id])
		@reward = Reward.find(params[:reward_id])
		@amount = @reward.amount

		customer = Stripe::Customer.create(
	    :email => @email,
	    :card  => params['id']
  	)

  	charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => @project.title,
	    :currency    => 'cad',
	    :capture => true
  	)
  	@pledge = @reward.pledges.create(user_id: current_user.id, project_id: @project.id)

  	respond_to do |format|
  		format.json { render json: {shipping: @reward.shipping, url: edit_project_reward_pledge_path(@project.id, @reward.id, @pledge.id) } }
  	end

  	# if @reward.shipping
  	# 	redirect_to edit_project_reward_pledge_path(@project.id, @reward.id, @pledge.id)
  	# else
  	# 	redirect_to project_path(@project), notice: 'Project successfully backed!'
  	# end

		rescue Stripe::CardError => e
		  	flash[:error] = e.message
		  	redirect_to project_reward_path(@project)
	end
end
