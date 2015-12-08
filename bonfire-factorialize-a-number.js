// Bonfire: Factorialize a Number
// Author: @cody-cooper
// Challenge: http://www.freecodecamp.com/challenges/bonfire-factorialize-a-number
// Learn to Code at Free Code Camp (www.freecodecamp.com)

function factorialize(num) {
  var factorial = 1;
  for (var n = 2; n <= num; n++) {
    factorial = factorial * n;
  }
  return factorial;
}

factorialize(5);