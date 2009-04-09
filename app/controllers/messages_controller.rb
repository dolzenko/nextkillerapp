class MessagesController < ApplicationController
  def index
    @messages = Message.all
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

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(messages_url) }
      else
        format.html { render :action => "edit" }
      end
    end
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
