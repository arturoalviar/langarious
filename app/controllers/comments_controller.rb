class CommentsController < ApplicationController

  #check if user is logged in before user makes comment
  before_action :authenticate_user!
  before_action :find_joke_and_comment, except: :create
  #create comment
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.joke_id = params[:joke_id]

    if @comment.save
      redirect_to joke_path(@comment.joke)
    end

  end

  def destroy
    @comment.destroy
    redirect_to joke_path(@joke)
  end

  def upvote
    @comment.upvote_by current_user
    redirect_to @joke
  end

  def downvote
    @comment.downvote_by current_user
    redirect_to @joke
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_joke_and_comment
    @joke = Joke.find(params[:joke_id])
    @comment = Comment.find(params[:id])
  end

end
