$(function (){
  $('#all-languages-added').mouseover(function(){
    $('#add-text').html('<em>You Rock! Tracks Added!</em>');
  });
  $('#all-languages-added').mouseleave(function(){
    $('#add-text').html('Add a Language');
  });
});
