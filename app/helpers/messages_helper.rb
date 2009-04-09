module MessagesHelper
	def wrap_in_edit_link(message, html)
		return link_to(html, edit_message_path(message))
	end
end
