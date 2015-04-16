$(function(){
  $('#datetimepicker').datetimepicker();

  if ($("#timezone")[0]){
    var d = new Date()
    var n = (d.getTimezoneOffset() / 60);
    $('#timezone').attr("value", n)
  }
})
