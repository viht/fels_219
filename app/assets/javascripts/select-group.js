$(document).ready(function(){
  $('.slectOne').on('change', function() {
    $('.slectOne').not(this).prop('checked', false);
  });
});
