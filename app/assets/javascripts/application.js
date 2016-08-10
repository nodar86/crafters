// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap-table
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .

$("#message").fadeTo(2000, 500).slideUp(500, function(){
        $("#message").alert('close');
});

$('#delete-confirm').on('show', function() {
      var $submit = $(this).find('.btn-danger'),
            href = $submit.attr('href');
              $submit.attr('href', href.replace('pony', $(this).data('id')));
});

$('.delete-confirm').click(function(e) {
      e.preventDefault();
        $('#delete-confirm').data('id', $(this).data('id')).modal('show');
});
