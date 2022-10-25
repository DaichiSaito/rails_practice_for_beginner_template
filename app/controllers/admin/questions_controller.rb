class Admin::QuestionsController < Admin::BaseController
  def index
    @questions = Question.all
  end

  def destroy
    @questions = Question.find(params[:id])
    @questions.destroy!
    redirect_to admin_questions_path
  end
end
