$(function(){
  setTimeout(function(){
    $('#notice_wrapper').fadeOut("slow", function(){
      $(this).remove();
    });
  }, 600);
}); 
