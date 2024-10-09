class BoardsController < ApplicationController
	def index
		@boards = Board.page(params[:page])
	end

	def new
		@board = Board.new(flash[:board])
	end

	def create
		board = Board.new(board_params)
		if board.save
			redirect_to board, flash: {
				notice: "「#{board.title}」の掲示板を作成しました。"
			}
		else
			redirect_to new_board_path, flash: {
				board: board,
				error_messages: board.errors.full_messages
			}
		end
	end

	def show
		@board = Board.find(params[:id])
		@comment = Comment.new(board_id: @board.id)
	end

	def edit
		@board = Board.find(params[:id])
	end

	def update
		board = Board.find(params[:id])
		if board.update(board_params)
			redirect_to board, flash: {
				notice: "投稿を更新しました。"
			}
		else
			redirect_back fallback_location: board, flash: {
				board: board,
				error_messages: board.errors.full_messages
			}
		end
	end

	def destroy
		board = Board.find(params[:id])
		board.destroy

		redirect_to boards_path, flash: {
			notice: "「#{board.title}」の掲示板が削除されました。"
		}
	end

	private
	def board_params
		params.require(:board).permit(:author_name, :title, :body)
	end
end