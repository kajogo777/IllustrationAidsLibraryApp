
  $(document).ready(function(){
      
      // var autocom = [];
      // $.ajax({
      //         url: $("#tokenfield-typeahead").attr('linktotags'),
      //         dataType: "json",
      //         success: function( data ) {
      //           autocom = data;
      //         }
      //       });


      $('#tokenfield-typeahead').tokenfield({
        autocomplete:
              { minLength: 2,   
                source: function(request, response) {
                  $.ajax({
                          url: $("#tokenfield-typeahead").attr('linktotags'),
                          dataType: "json",
                          data: {
                            req: request.term
                          },
                          success: function( data ) {
                            response( data );
                          }
                        });
                } 
              },showAutocompleteOnFocus: true
        });


      $('#tokenfield-typeahead').on('tokenfield:createtoken', function (event) {

          var existingTokens = $(this).tokenfield('getTokens');
          $.each(existingTokens, function(index, token) {
            if (token.value === event.attrs.value)
              event.preventDefault();
          });

          // var exists = true;
          // $.each(autocom, function(index, token) {
          //   if (token === event.attrs.value)
          //     exists = false;
          // });
          // if(exists === true)
          //   event.preventDefault();

        });

    });
