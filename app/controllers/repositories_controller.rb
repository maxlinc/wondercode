class RepositoriesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :set_repository, only: [:show, :edit, :update, :destroy]

  # GET /repositories
  def index
    @repositories = Repository.all
  end

  # GET /repositories/1
  def show
  end

  # GET /repositories/new
  def new
    @user = current_user
    octokit = @user.octokit
    github_repo = octokit.repo owner: @user.nickname, repo: params[:repo]
    @repository = Repository.new(
      name: github_repo.name,
      repo_url: "http://github.com/#{@user.nickname}/#{github_repo.name}",
      url: github_repo.homepage,
      languages: [github_repo.language],
      description: github_repo.description
    )
  end

  # GET /repositories/1/edit
  def edit
  end

  # POST /repositories
  def create
    @repository = Repository.new(repository_params.merge({
        login: current_user.nickname,
        languages: ['placeholder']
      })
    )

    if @repository.save
      redirect_to @repository, notice: 'Repository was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /repositories/1
  def update
    if @repository.update(repository_params)
      redirect_to @repository, notice: 'Repository was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /repositories/1
  def destroy
    @repository.destroy
    redirect_to repositories_url, notice: 'Repository was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      unless params[:repo].nil?
        @repository = Repository.where(login: params[:repository_id], name: params[:repo]).first
      else
        @repository = Repository.find params[:id]
      end
    end

    # Only allow a trusted parameter "white list" through.
    def repository_params
      params.require(:repository).permit(
        :name, :description, :login,
        :repo_url, :url, :type
      )
      # language is tricky
    end
end
