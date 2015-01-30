$(document).ready(function(){
	$(document).on("submit", "#commentForm", function(){
		var that = this;
		$.ajax({
			url: "/reviews",
			type: 'POST',
			data: $(that).serialize(),
			success: function(data){
				$(".prependReviews").prepend(data);
				$("#name").val("");
				$("#comment").val("");
			}
		});
		return false;
	});
});