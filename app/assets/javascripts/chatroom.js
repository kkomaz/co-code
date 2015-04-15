$(function(){
  chatboxScroll();
});

function chatboxScroll(){
  var height = 0;
  $('#chatbox div.message-container').each(function(i, value){
      height += parseInt($(this).height());
  });
  height += '';
  $('#chatbox').animate({scrollTop: height});
}

function newMessageScroll(){
  var $targetEl = $("#chatbox").children().last()
  $("#chatbox").animate({
    scrollTop: $("#chatbox").scrollTop() + $targetEl.position().top
  });
}

function refreshUsers(channel, channelKey, status){
  var url = channel + '/refresh'
  $.ajax({
    method: "POST",
    url: url,
    data: {channel: channel, channel_key: channelKey, status: status},
    dataType: "script"
  })
}
