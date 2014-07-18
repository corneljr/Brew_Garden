class CommentsController < ApplicationController
	include ActionController::Live

	before_action :load_project
	before_action :load_user
	before_filter :require_login, :only => [:create]

  def index
  	 @commentable = find_commentable
  	 @comments = @commentable.comments
     @comment = Comment.new

     if request.xhr?
      render partial: 'project_comments' 
    end
  end

  def create
  	@commentable = find_commentable
  	@comment = @commentable.comments.build(comment_params)
  	@comments = @commentable.comments
	  respond_to do |format|
      if @comment.save
        format.js 
      else
        format.html { render 'projects/show', alert: 'There was an error.'  }
        format.js 
      end
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
