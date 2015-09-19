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


$(document).ready(function() {
    var max_fields      = 5; //maximum input boxes allowed
    var wrapper         = $(".input_fields_wrap"); //Fields wrapper
    var add_button      = $(".add_field_button"); //Add button ID
    
    var x = 1; //initlal text box count
    $(add_button).click(function(e){ //on add input button click
        e.preventDefault();
        if(x < max_fields){ //max input box allowed
            x++; //text box increment
            $(wrapper).append('<div><input type="text" name="task[answers][]" class = " form-control input-sm" placeholder="Answer #'+x+'"/><a href="#" class="remove_field">Remove</a></div>'); //add input box
        }
    });
    
    $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
        e.preventDefault(); $(this).parent('div').remove(); x--;
    })
});


$(document).ready(function(){
$("#tagcloud").tx3TagCloud({
multiplier: 1 // default multiplier is "1"
});
});

$(document).ready(function(){
  $('#autocomplete_tag').bind('railsAutocomplete.select', function(event, data){
  $('#form').append('<input type=hidden name=task[tags][] value="'+data.item.value+'"/>');
});
});