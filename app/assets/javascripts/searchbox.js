
  $(document).ready(function(){
      
      var autocom = [];
      // $.ajax({
      //         url: $("#tokenfield-typeahead").attr('linktotags'),
      //         dataType: "json",
      //         success: function( data ) {
      //           autocom = data;
      //         }
      //       });

      autocom = ['king','queen','fish'];

      $('#tokenfield-typeahead').tokenfield({
        autocomplete:
              { minLength: 2,   
                source: function(request, response) {
                  var value = request.term.toLowerCase();
                  var result = [];
                  for(var i = 0; i < autocom.length; i++)
                  {
                    if( autocom[i].search(value) > -1)
                    {
                      result.push(autocom[i]);
                    }
                  }
                  response(result);
                } 
              },showAutocompleteOnFocus: true
        });


      $('#tokenfield-typeahead').on('tokenfield:createtoken', function (event) {

          var existingTokens = $(this).tokenfield('getTokens');
          $.each(existingTokens, function(index, token) {
            if (token.value === event.attrs.value)
              event.preventDefault();
          });

          var exists = true;
          $.each(autocom, function(index, token) {
            if (token === event.attrs.value)
              exists = false;
          });
          if(exists === true)
            event.preventDefault();

        });

    });
