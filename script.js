var input = document.getElementById('input'),
    number = document.getElementById('number'),
    output = document.getElementById('output')
function updateBG(){
  document.body.style.background = input.value
}
function lighten(hex,step,direction){
  hexShift(hex,step,'up')
}
function darken(hex,step,direction){
  hexShift(hex,step,'down')
}
function hexShift(hex,step,direction){
  var color = hex.replace(/#/g,'')
  var swatch = ''
  var newColor = ''
  if (color.length == 3){
    var swatch = ''
    for(i=0;i<color.length;i++){
      swatch += color.substring(i,i+1) + color.substring(i,i+1)
    }
    color = swatch
  }
  for (i=0;i<6;i++){
    var num = parseInt(color.substring(i,i+2),16)
    var oper = direction=='up'?'+':'-'
    var value = eval(num+oper+step)
    if (value > 255) {
      value = 255
    } else if (value < 0){
      value = 0
    }
    value = value.toString(16)
    value = value.length==1?0+value:value;
    newColor += value
    i++
  }
  newColor = '#'+newColor
  output.value = newColor
  document.documentElement.style.background = newColor
}