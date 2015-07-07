
$(document).ready(function(){

	$("#crud-srch").on("ajax:success", function(e, data, status, xhr){
        eval(xhr.responseText);
    });

    $(".add-sub").on("click", function(event){
    	time = new Date().getTime();
    	regex = new RegExp($(this).data('id'),'g');
    	$(this).before($(this).data('fields').replace(regex,time));
    	event.preventDefault();
    });

    $('[data-toggle="popover"]').popover({
        html: true,
        trigger: 'hover',
        content: function () {
          return '<img src="'+$(this).data('img') + '" />';
        }
    });

    $('[data-toggle="popovert"]').popover({
        html: true,
        trigger: 'hover'
    });

    $('.modal').on('hidden.bs.modal', function (e) {
        if($('.modal').hasClass('in')) {
        $('body').addClass('modal-open');
        }    
    });

    $(".create-form-close").on("click",(function(){

        if( $('#notice-location-form').find('#notice').length )
        {
          $.ajax({
            url: $("#create-form").attr('linkto'),
            dataType: "script"
          });
        }

      }));


});