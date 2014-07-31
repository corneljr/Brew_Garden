class ChargesController < ApplicationController
	before_action :require_login, only: [:create]

	def create
		@email = params[:stripeEmail]
		@project = Project.find(params[:project_id])
		@reward = Reward.find(params[:reward_id])
		@amount = @reward.amount

		customer = Stripe::Customer.create(
	    :email => @email,
	    :card  => params[:stripeToken]
  	)

  	charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => @project.title,
	    :currency    => 'cad',
	    :capture => true
  	)

  	@pledge = @reward.pledges.create(user_id: current_user.id, project_id: @project.id)

  	if @reward.shipping
  		redirect_to edit_project_reward_pledge_path(@project, @reward, @pledge)
  	else
  		redirect_to project_path(@project), notice: 'Project successfully backed!'
  	end

		rescue Stripe::CardError => e
		  	flash[:error] = e.message
		  	redirect_to project_reward_path(@project)
	end
end
