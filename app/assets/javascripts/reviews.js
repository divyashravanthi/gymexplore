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
				$("#rating").val("");
				$("#giveReview").modal('hide');
				$(".showClear").rating("refresh",{disabled: true, showClear: false});
			}
		});
		return false;
	});
});