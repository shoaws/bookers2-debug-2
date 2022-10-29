class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_tag = @book.tags
  end

  def index
    @books = Book.all
    @book = Book.new
    @tag_list=Tag.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:name].split(',')
    if @book.save
      @book.save_tag(tag_list)
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @tag_list = @book.tags.pluck(:name).join(',')
    if @book.user !=current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    tag_list = params[:book][:name].split(',')
    if @book.update(book_params)
      # このpost_idに紐づいていたタグを@oldに入れる
      old_tags = Booktag.where(book_id: @book.id)
      # それらを取り出し、消す。消し終わる
      old_tags.each do |tag|
        tag.delete
      end
      @book.save_tag(tag_list)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def text
    @books = Book.all
  end

  def novel
    @books = Book.all
  end

  def comic
    @books = Book.all
  end

  def others
    @books = Book.all
  end

  def search_tag
    @book = Book.new
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @books = @tag.books
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:star,:category)
  end
end
