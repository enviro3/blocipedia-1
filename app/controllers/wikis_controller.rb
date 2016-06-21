class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
    #authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    #authorize @wiki
  end

  def new
    #@user = my_user
    @wiki = Wiki.new
    #authorize @wiki
  end

  def create
    @wiki = Wiki.new(user: current_user)
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    
    if @wiki.save
      flash[:notice] = "Post was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
     
    # @wiki = current_user.wikis.create(wiki_params)
    # authorize @wiki
    # # adding owner to collaborator list
    # # collaborator = @wiki.collaborators.build(user_id: current_user.id)
  end

  def edit
    @wiki = Wiki.find(params[:id])
  #   @wiki = Wiki.find(params[:id])
  #   authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
  #   @wiki = Wiki.find(params[:id])
  #   authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
  #   title = @wiki.title
  #   authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end

  end
end