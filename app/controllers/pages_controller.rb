class PagesController < ApplicationController
  def show
    if page_exists?
      render template: "pages/#{params[:page]}"
    else
      render file: Pathname.new(Rails.root + "public/404.html"), status: :not_found
    end
  end

  private

  def page_exists?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.haml"))
  end
end
