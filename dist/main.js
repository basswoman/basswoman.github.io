/******/ (() => { // webpackBootstrap
console.log('main.js');
console.log(Module);

   // fancy colours
function getRandomColor() {
  var letters = '0123456789ABCDEF'.split('');
  var color = '#';
  for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

// message printout
function print_msg(message) {
   var messField = document.getElementById("console") 
   messField.innerText = message;
   messField.style.color = getRandomColor();
};


function main() {

    console.log('main');
  console.log = print_msg;
  console.warn = print_msg;

  // function to be called after Wasm Csound is loaded
 Module["onRuntimeInitialized"] = function (){
    console.log("loading... loaded!");
    
    var csound = new CsoundObj();
    console.log(document.getElementById('instruments').value);
    csound.compileOrc(document.getElementById('instruments').value);
    csound.start();

     window.addEventListener("unload", function(e){
    if(csound != null)
            csound.destroy();
    }, false);

  };
}

$(() => {
    main();

    $('#start').click(() => {
        console.log('click');
        // csound.start();
    });
});


/******/ })()
;