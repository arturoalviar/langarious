class Api::CommentsController < Api::ApiController

  before_action :find_joke

  def create
    comment = Comment.new(comment_params)
    comment.user_id = User.find(1)
    comment.joke_id = params[:joke_id]

    if comment.save
      render status: 200, json: {
        message: "Successfully created your cool comment",
        joke: @joke,
        comment: comment
      }.to_json
    else
      render status: 422, json: {
        message: comment.errors
      }.to_json
    end
  end

  def destroy
    comment = @joke.comments.find(params[:id])
    comment.destroy
    render status: 200, json: {
        message: "Successfully deleted your boring comment",
        joke: @joke,
        comment: comment
      }.to_json
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_joke
    @joke = Joke.find(params[:joke_id])
  end

end
