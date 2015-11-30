class Api::JokesController < Api::ApiController

  before_action :find_joke, except: [:index]

  def index
    render json: Joke.all
  end

  def show
    render json: @joke.as_json(include: [:comments])
  end

  def create
    joke = Joke.new(joke_params)
    joke.user = User.find(1)
    if joke.save
      render status: 200, json: {
        message: "Successfully created your hilarious joke.",
        joke: joke
      }.to_json
    else
      render status: 422, json: {
        message: joke.errors
      }.to_json
    end
  end

  def update
    if joke.update(joke_params)
      render status: 200, json: {
        message: "Successfully updated your funny joke",
        joke: joke
      }.to_json
    else
      render status: 422, json: {
        message: "Oh no, your funny joke could not updated :( ",
        joke: joke
      }.to_json
    end
  end

  def destroy
    joke.destroy
    render status: 200, json: {
      message: "Successfully deleted your bad joke"
    }.to_json
  end

  private

  def find_joke
    @joke = Joke.find(params[:id])
  end

  def joke_params
    params.require(:joke).permit(:title, :body)
  end
end
