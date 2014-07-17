class CommentsController < ApplicationController

	before_action :load_project
	before_action :load_user

  def index
  	 @commentable = find_commentable
  	 @comments = @commentable.comments
  end

  def create
  	@commentable = find_commentable
  	@comment = @commentable.comments.build(comment_params)
	  if @comment.save
	    flash[:notice] = "Successfully created comment."
	    redirect_to polymorphic_path(@commentable) 
	  else
	    render :action => 'new'
	  end
  end

  private

	def find_commentable
	  params.each do |name, value|
	    if name =~ /(.+)_id$/
	      return $1.classify.constantize.find(value)
	    end
	  end
	  nil
	end

	def comment_params
		params.require(:comment).permit(:body)
	end

	def load_project
    @project = Project.find(params[:project_id]) if params[:project_id]
  end
  
  def load_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
