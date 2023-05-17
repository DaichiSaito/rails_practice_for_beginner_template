class AnswersController < ApplicationController
    def create
        @answer = current_user.answers.build(answer_params)
        @answer.question_id = params[:question_id]
        if @answer.save
            redirect_to question_path(params[:question_id]), notice: '回答を投稿しました。'
        else
            @question = Question.find(params[:question_id])
            render 'questions/show'
        end
    end

    def destroy
        @answer = current_user.answers.find(params[:id])
        @answer.destroy!
        redirect_to question_path(params[:question_id]), notice: '回答を削除しました。'
    end

    def edit
        @answer = current_user.answers.find(params[:id])
    end

    def update
        @answer = current_user.answers.find(params[:id])
        @answer.edited = true
        if @answer.update(answer_params)
            redirect_to question_path(params[:question_id]), notice: '回答を更新しました。'
        else
            render :edit
        end
    end

    private
    def answer_params
        params.require(:answer).permit(:body)
    end
end
