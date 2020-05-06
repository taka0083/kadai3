class BooksController < ApplicationController
	before_action :authenticate_user!

    before_action :ensure_correct_user,{only: :edit}

  def ensure_correct_user
    @book =Book.find(params[:id])
    if @book.user_id != current_user.id
        redirect_to books_path
    end
  end


    def new
    end
    def create
    	@book = Book.new(book_params)
    	@book.user_id = current_user.id
	    if @book.save
	    	flash[:notice]="successfully"
	    redirect_to book_path(current_user.id)
	    else
            @books = Book.all
	    	@user = current_user
	    	flash[:notice]="error"
	    	render :index
	    end
    end
    def index
  	    @book= Book.new
  	    @books=Book.all
        @user = current_user
    end

    def show
        @book = Book.find(params[:id])
        @user = @book.user
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
         @book =Book.find(params[:id])
         if @book.update(book_params)
            flash[:notice]="Book was successfully updated."
            redirect_to book_path(@book.id)
         else
            flash[:notice]="error."
            render :edit
         end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end

    # 投稿データのストロングパラメータ
    private
    def book_params
        params.require(:book).permit(:title, :body)
    end

end
