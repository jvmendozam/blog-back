class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :update, :destroy]

  # GET /blogs
  def index
    @blogs = Blog.all
    # @blogs.each do |blog|
    #   blog.picture =  'test' #Base64.encode64(File.read(blog.picture.path))
    # end
    render json: @blogs
  end

  # GET /blogs/1
  def show
    render json: @blog
  end

  # POST /blogs
  def create
    debugger
    puts params
    blog = Blog.new(blog_params)
    decoded_file = Base64.decode64(params[:blog][:picture])
    begin
      file = Tempfile.new(['test', '.jpg']) 
      file.binmode
      file.write decoded_file
      file.close
      blog.picture =  file
      if blog.save
        render json: blog, status: :created, location: blog
      else
        render json: blog.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /blogs/1
  def update
    if @blog.update(blog_params)
      render json: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blog_params
      params.require(:blog).permit(:id, :title, :resume, :picture, :body)
    end
end
