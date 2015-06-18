//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery-ui
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require cocoon
  
  $(document).ready(function(){
      $.material.init();
      
      $("#search-cat li a").on("click",(function(){

        $("#b1").text($(this).text());

        $('#cat-hidden').val($(this).attr('value'));
        $('#subcat-hidden').val("0");

        if($('#cat-hidden').val() == 0){ $("#b2").remove(); }

        $.ajax({
          url: $("#locationbtsub").attr('linktosub'),
          data: {
            cat_id : $(this).attr('value')
          },
          dataType: "script"
        });

      }));

      $("#locationbtsub").on("click","#search-subcat li a",(function(){

        $("#b2").text($(this).text());

        $('#subcat-hidden').val($(this).attr('value'));

      }));

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

  