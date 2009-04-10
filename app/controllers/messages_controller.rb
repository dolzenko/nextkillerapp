class MessagesController < ApplicationController
	protect_from_forgery :except => :toggle_favorite

  def index
    @messages = Message.active
    respond_to do |format|
      format.html
    end
  end

  def trash
    @messages = Message.trash
    respond_to do |format|
      format.html { render :action => "index" }
    end
  end

	def search
    @messages = Message.find(:all, :conditions => [ "subject LIKE ?", "%#{params[:q]}%"])
    respond_to do |format|
      format.html { render :action => "index" }
    end
  end

	def move_to_trash
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes({:in_trash => true})
        flash[:notice] = 'Message moved to trash.'
        format.html { redirect_to(messages_url) }
      else
        format.html { render :action => "edit" }
      end
    end
	end

  def new
    @message = Message.new
    respond_to do |format|
      format.html { render :action => "edit" }
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(messages_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def update
    @message = Message.find(params[:id])

		#params[:message]
    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(messages_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

	def toggle_favorite
    @message = Message.find(params[:id])
		@message.update_attributes({:important => !@message.important})
		render :js => %Q{$("favimg_" + #{params[:id]}).className = "#{@message.important ? "" : "non_"}favorite";}
	end

  def destroy
    @message = Message.find(params[:id])

		if @message.in_trash
			flash[:notice] = 'Message was deleted.'
			@message.destroy
			redirect_target = trash_messages_url
		else
			flash[:notice] = %Q{Message was sent to <a href="#{trash_messages_url}">Trash</a>.}
			@message.update_attributes({:in_trash => true})
			redirect_target = messages_url
		end

    respond_to do |format|
      format.html { redirect_to(redirect_target) }
    end
  end
end
