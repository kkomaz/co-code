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
