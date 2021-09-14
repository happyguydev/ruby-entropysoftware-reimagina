jQuery -> 
	$("#instrumentQuestionsPosition").sortable
		axis: "y"
		cursor: "move"
		update: ->
			$.ajax
				type: "POST"
				url: $(this).data('update-url')
				data: $(this).sortable('serialize')
				dataType: "JSON"
	$(".instrumentAlternativesPosition").sortable
		cursor: "move"
		update: ->
			$.ajax
				type: "POST"
				url: $(this).data('update-url')
				data: $(this).sortable('serialize')
				dataType: "JSON"