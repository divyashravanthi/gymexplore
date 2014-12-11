$(document).ready(function() {
    var max_fields      = 10; //maximum input boxes allowed
    var wrapper         = $(".pricing-wrapper"); //Fields wrapper
    var add_button      = $("#add-pricing"); //Add button ID
    
    var x = 1; //initlal text box count
    $(add_button).click(function(e){ //on add input button click
        e.preventDefault();
        if(x < max_fields){ //max input box allowed
            x++; //text box increment
            $(wrapper).append('<div class="row"> <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"> <div class="form-group"> <div class="input-group"> <input class="form-control" type="number" placeholder="Ex: 3" name="duration[]"> <div class="input-group-addon">Month(s)</div></div></div></div><div class="col-xs-12 col-sm-12 col-md-5 col-lg-5"> <div class="form-group"> <div class="input-group"> <div class="input-group-addon">Rs.</div><input class="form-control" type="text" placeholder="Ex: 5000.00" name="price[]"> </div></div></div><a href="#" class="btn btn-danger remove-pricing"> - </a></div>'); //add input box
        }
    });
    
    $(wrapper).on("click",".remove-pricing", function(e){ //user click on remove text
        e.preventDefault(); $(this).parent('div').remove(); x--;
    });

    if($(".notice-alert").length > 0){
        var n = noty({
            text: $(".notice-alert").text(),
            layout: 'bottomRight',
            type: 'information',
            animation: {
                open: 'animated flipInX', // Animate.css class names
                close: 'animated flipOutX', // Animate.css class names
            },
            theme: 'relax',
            killer: false,
            closeWith: ['click', 'button']
        });
    }
});