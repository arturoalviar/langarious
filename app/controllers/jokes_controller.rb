class JokesController < ApplicationController

  before_action :find_joke, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user! , except: [:index, :show]

  #used by index page to get all jokes
  def index
    @jokes = Joke.all()
  end

  #user makes new joke
  def new
    @joke = current_user.jokes.build
  end

  #save joke into database if it has required params
  def create
    @joke = current_user.jokes.build(joke_params)
    if @joke.save
      upvote_on_post
      redirect_to @joke
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new
    @comment.joke_id = @joke.id

    if user_signed_in?
      @signed_in_username = User.find(current_user).username
    end
  end

  def edit
  end

  def update
    if @joke.update(joke_params)
      flash.notice = "Your funny joke has been updated!"
      redirect_to @joke
    else
      render 'edit'
    end
  end

  def destroy
    @joke.destroy
    redirect_to root_path
  end

  def upvote_on_post
    @joke.upvote_by current_user
  end

  def upvote
    @joke.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @joke.downvote_by current_user
    redirect_to :back
  end

  private

  def find_joke
    @joke = Joke.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
    return
  end

  def joke_params
      params.require(:joke).permit(:title, :body, :tag_list)
  end

end
