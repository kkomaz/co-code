$(function(){
  var clickedElements = []
  $(".profile-img img").on("dblclick", function(){
    if(!clickedElements.some(exists, this)){
      clickedElements.push(this);
    }
    if(awesomeThing(clickedElements)){
      clickedElements = []
    }
  })

})

function awesomeThing(elements) {
  if(elements.length === 3){
    $(".profile-img img").fadeTo(400, 0, function(){
      var newImg = $("#miller").attr("src")
      $(this).attr("src", newImg).bind('onreadystatechange load', function(){
        if (this.complete) $(this).fadeTo(400, 1);
      });
    });
    $(".profile-img h4").fadeTo(400, 1, function(){
      $(this).text("JACKPOT!").bind('onreadystatechange load', function(){
      });
    });
    $(".team-label h2").fadeTo(400, 1, function(){
      $(this).text("IT'S MILLER TIME!").bind('onreadystatechange load', function(){
      });
    });

    return true;
  } else {
    return false;
  }
}

function exists(element){
  if(element == this){
    return true
  } else {
    return false
  }
}