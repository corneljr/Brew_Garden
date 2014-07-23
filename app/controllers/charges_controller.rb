class ChargesController < ApplicationController
	def new
	end

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
	    :currency    => 'cad'
  	)

  	redirect_to project_path(@project), notice: 'thanks for backing the project!'

		rescue Stripe::CardError => e
		  	flash[:error] = e.message
		  	redirect_to project_reward_path(@project)
		end
end
