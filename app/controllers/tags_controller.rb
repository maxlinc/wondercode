class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  def show
    @tag = Tag.where(name: "#{params[:user]}::#{params[:repo]}").first
    @repos = @tag.repositories
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to @tag, notice: 'Tag was successfully created.'
    else
      render action: 'new'
    end
  end
  
  def add
    @tag = Tag.find_or_create_by(name: params[:new_tag])
    repository = Repository.find(params[:repository])
    @tag.repositories << repository
    repository.tags << @tag
    repository.save
    @tag.save
    redirect_to repositories_url
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      redirect_to @tag, notice: 'Tag was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    redirect_to tags_url, notice: 'Tag was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.where(name: params[:id]).first
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end
