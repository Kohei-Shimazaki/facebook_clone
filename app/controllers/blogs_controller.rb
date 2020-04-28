class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :jump_to_login, only: [:index, :show, :new, :create, :edit, :update]
  before_action :authenticate_user, only: [:edit, :update, :destroy]
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.build(blog_params)
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'ブログを作成しました！' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'ブログを更新しました！' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'ブログを削除しました！' }
      format.json { head :no_content }
    end
  end
  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end
    # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:content, :picture, :picture_cache)
  end
  def jump_to_login
    if current_user == nil
      redirect_to sessions_new_path, notice: "ログイン、またはサインアップして下さい！"
    end
  end
  def authenticate_user
    if current_user.id != Blog.find(params[:id]).user_id
      redirect_to blogs_path, notice: "他のユーザのブログは編集できません！"
    end
  end
end
