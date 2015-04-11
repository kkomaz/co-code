$(function(){
  chatboxScroll();
});

function commentScroll(){
  var commentParent = $("#comment-form-parent"), pos = commentParent.offset();
  $(window).scroll(function() {
    if($(this).scrollTop() > (pos.top - 85) && commentParent.css('position') == 'static') {
      commentParent.addClass('fixed');
    } else if($(this).scrollTop() <= (pos.top - 85) && commentParent.hasClass('fixed')){
      commentParent.removeClass('fixed');
    }
  });
}

function chatboxScroll(){
  var height = 0;
  $('#chatbox div.message-container').each(function(i, value){
      height += parseInt($(this).height());
  });
  height += '';
  $('#chatbox').animate({scrollTop: height});
}