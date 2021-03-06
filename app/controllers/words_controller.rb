class WordsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :load_category, only: [:create, :new]
  before_action :load_word, only: [:edit, :update, :destroy]
  before_action :delete_questions_if_exit

  def index
    @categories = Category.all
    condition = params[:condition].nil? ? "all" : params[:condition]
    @words = Word.send("by_#{condition}", current_user.id, category_id)
      .paginate page: params[:page], per_page: Settings.list
  end

  def new
    @word = @category.words.build
      Settings.answer_size_default.times {@word.answers.build}
  end

  def create
    @word = @category.words.build word_params
    if @word.save
      flash[:success] = t "created_success"
      redirect_to @category
    else
      flash[:danger] = t "create_fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "updated_success"
      redirect_to @word.category
    else
      flash[:danger] = t "update_fail"
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "deleted_success"
    else
      flash[:danger] = t "delete_fail"
    end
    redirect_to @word.category
  end

  private

  def word_params
    params.require(:word).permit :content,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = t "please_login_user_admin"
      redirect_to root_url
    end
  end

  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "error_load"
      redirect_to categories_url
    end
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "error_load"
      redirect_to categories_url
    end
  end

  def category_id
    params[:category_id].blank? ? @categories.map(&:id) : params[:category_id]
  end
end
