//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery-ui/accordion
//= require jquery-ui/autocomplete
//= require jquery-ui/button
//= require jquery-ui/datepicker
//= require jquery-ui/dialog
//= require jquery-ui/menu
//= require jquery-ui/progressbar
//= require jquery-ui/selectmenu
//= require jquery-ui/slider
//= require jquery-ui/spinner
//= require jquery-ui/tabs
//= require jquery-ui/tooltip
//= require jquery-ui/effect.all
//= require jquery-ui/effect
//= require jquery-ui/effect-blind
//= require jquery-ui/effect-bounce
//= require jquery-ui/effect-clip
//= require jquery-ui/effect-drop
//= require jquery-ui/effect-explode
//= require jquery-ui/effect-fade
//= require jquery-ui/effect-fold
//= require jquery-ui/effect-highlight
//= require jquery-ui/effect-puff
//= require jquery-ui/effect-pulsate
//= require jquery-ui/effect-scale
//= require jquery-ui/effect-shake
//= require jquery-ui/effect-size
//= require jquery-ui/effect-slide
//= require jquery-ui/effect-transfer
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require bootstrap-tokenfield
//= require tokenfield
//= require cocoon
  
  $(document).ready(function(){
      
      
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