if (location.pathname === '/welcome' || location.pathname === '/welcome/') {
  location = '/welcome/edit?html,live';
}

if (window.location.pathname.indexOf('/edit') !== -1) $('a.open').click(function (event) {
  event.preventDefault();
  window.top.$('a[href$="' + this.hash + '"]').mousedown().click();
});

var presses = 0;

var spin = [
  "Woahohaohaohaahoahaohaohaohaohaoha...",
  "Nononono...aiiiiiiiiiiiiieeeeeeee....",
  "Aaaaaaaaaghhhhh...woahwoahwoahwoahwoah...",
  "You're eeeeeeeeviiiiiiilllllllll....",
  "Eee...eee...eee...eee...eee...",
  "Woowoowoowoowoowoowoowoowoo..."
];
  
var stop = [
  "Please... never again.",
  "I'm so dizzy.",
  "That's just... cruel.",
  "Don't you have better things to do?",
  "I can't feel my toes... oh wait, I don't have any toes!",
  "This isn't fun anymore.",
  "...",
  "I'm going to be sick.",
  "Uh-oh, I think I just dropped some tables...",
  "Yep, I think I'm about to SQL-project everywhere...",
  "SELECT * FROM `stomach`...",
  "var_dump($result)...",
  "+_+"
];

$('#dave').mousedown(function () {
  
  $('#message').fadeOut(function () {
    $(this).text(spin[presses % spin.length]);
    presses = presses + 1;
  }).fadeIn();
  
}).mouseup(function () {
  
  $('#message').fadeOut(function () {
    $(this).text(stop[presses % stop.length]);
  }).fadeIn();
  
  if( presses >= stop.length - 1 ) {
	$(this).animate({left: '-999px'}, 1000 * 10, function () {
      $(this).animate({left: '0'}, 1000 * 4);
      presses = 0;
    });
  }
  
});