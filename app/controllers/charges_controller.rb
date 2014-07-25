class ChargesController < ApplicationController
	protect_from_forgery with: :exception
	before_action :require_login

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

  	redirect_to project_reward_path(@project, @reward)

		rescue Stripe::CardError => e
		  	flash[:error] = e.message
		  	redirect_to project_reward_path(@project)
	end

	def payment
		 event_json = JSON.parse(request.body.read)
		 Charge.transaction[:charge] = event_json
	end
end
