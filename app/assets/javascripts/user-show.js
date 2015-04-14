$(function (){
  $('#all-languages-added').mouseover(function(){
    $('#add-text').html('<em>All Tracks Added!</em>');
  });
  $('#all-languages-added').mouseleave(function(){
    $('#add-text').html('Add Language Track');
  });
});
