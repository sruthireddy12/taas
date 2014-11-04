jQuery ($) ->
  $(document).ready ->
  	dialog = $("#dialog-form").dialog(
		  autoOpen: false
		  height: 800
		  width: 1550
		  modal: true
		  buttons:
		    Cancel: ->
		      dialog.dialog "close"
		      return
		)
  	$("#new-application").on "click", (e) ->
  		dialog.dialog("open");
  		return