$(function(){
  $("#alex_l").on("dblclick", registerClick($this))
  $("#seiji").on("dblclick", registerClick($this))
  $("#alex_g").on("dblclick", registerClick($this))
})




function registerClick(element) {
  console.log (element)
}