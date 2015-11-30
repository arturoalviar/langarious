module Api
  class ApiController < ApplicationController

    #rails has a unique token for forms in our app
    #this prevents an error when submiting a form via an api call (e.g. curl)
    skip_before_filter :verify_authenticity_token
    protect_from_forgery with: :null_session

  end
end
