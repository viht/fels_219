class StaticPagesController < ApplicationController
  before_action :delete_questions_if_exit

  def home
  end
end
