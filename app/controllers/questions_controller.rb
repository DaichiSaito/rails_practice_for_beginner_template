class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
  end

  def solved
    @q = Question.where(solved: true).ransack(params[:q])
    @questions = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
    render :index
  end

  def unsolved
    @q = Question.where(solved: false).ransack(params[:q])
    @questions = @q.result(distinct: false).order(created_at: :desc).page(params[:page]).per(5)
    render :index
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      User.where.not(id: current_user.id).each do |user|
        QuestionMailer.with(user: user, question: @question).question_created.deliver_later
      end
      redirect_to question_path(@question), success: '質問を作成しました'
    else
      flash.now[:dander] = '失敗しました'
      render :new

    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end


  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path(@question), success: '質問を更新しました'
    else
      flash.now[:danger] = '失敗しました'
      render :edit
    end
  end

  def destroy
    @question = current_user.questions.find_by(params[:id])
    @question.destroy!
    redirect_to questions_path
  end

  def solve
    @question = current_user.questions.find(params[:id])
    @question.update(solved: true)
    redirect_to question_path(@question), success: '解決済みにしました'
  end

  private

  def question_params
    params.require(:question).permit( :title, :body )
  end
end
