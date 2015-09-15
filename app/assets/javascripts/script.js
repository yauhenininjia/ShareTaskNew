window.onload = function () {
  document.getElementById("upload_widget_opener").addEventListener("click", function() {

    cloudinary.openUploadWidget({ cloud_name: 'dy4pzclcw', upload_preset: 'p587tipa', form: 'form', field_name: 'task[images][]' }, 
      function(error, el) { 
        console.log(el);
        el.forEach(function(el, i, arr) {
          var preview = $("#preview");

          var a = $('<a/>').attr({href: el.url}).appendTo(preview);
          var id = el.public_id;

          $.cloudinary.image(el.public_id, {
            format: el.format, width: 50, height: 50, crop: "fit"
          }).attr('id', el.public_id).appendTo(a);
          $('input[data-cloudinary-public-id='+id+']').val(el.url);

          $('<a/>').
            addClass('delete_by_token').
            attr({href: '#', 'data-cloudinary-public-id': el.public_id}).
            data({delete_token: el.delete_token}).
            html('&times;').
            appendTo(preview).
            click(function(e) {
              e.preventDefault();
              $('input[data-cloudinary-public-id='+id+']').remove();
              $('img#'+id).remove();
              this.remove();
              $.ajax({
                method: 'GET',
                url: Routes.users_delete_image_path('en', {public_id: id}),
                success: function(result, status, xhr) {
                  console.log(result, status);
                },
                error: function(result, status, xhr) {
                  console.log(result, status, xhr);
                }
              });
          });
        });
      });
  }, false);
}