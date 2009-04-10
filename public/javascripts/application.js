function toggle_favorite(message_id)
{
	new Ajax.Request("/messages/toggle_favorite", {	parameters: {id: message_id}, method: 'post'	});
}
