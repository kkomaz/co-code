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

function getUsers(channel, clientId){
  if(!!$("div#chatbox")[0]) {
    // make ajax call to get user element and call addUsers function
  }
}

function addUsers(element){
  $("div#active-users").append(element)
}