class WikisController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @wikis = Wiki.all
    authorize @wikis
    @wikis = Wiki.visible_to(current_user)
    
    if current_user.premium? || current_user.admin?
      @wikis = Wiki.all
    end
    
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @user = current_user
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = current_user
    
    @wiki = Wiki.new(user: current_user)
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    
    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
     
    # @wiki = current_user.wikis.create(wiki_params)
    # authorize @wiki
    # # adding owner to collaborator list
    # # collaborator = @wiki.collaborators.build(user_id: current_user.id)
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user)
  end
  
  def authorize_user
    @user = User.find(params[:id])
    authorize @user
    unless current_user?
      flash[:alert] = "You must be a user to do that."
      redirect_to wikis_path
    end
  end

end