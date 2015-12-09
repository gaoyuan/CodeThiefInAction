// Bonfire: Repeat a string repeat a string
// Author: @lohanidamodar
// Challenge: http://www.freecodecamp.com/challenges/bonfire-repeat-a-string-repeat-a-string
// Learn to Code at Free Code Camp (www.freecodecamp.com)

function repeat(str, num) {
  // repeat after me
  var res = "";
  if(num > 0){
    for(;num > 0; num--){
      res += str;
    }
  }
  return res;
}

repeat("abc", 3);