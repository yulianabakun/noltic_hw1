document.addEventListener('DOMContentLoaded', function() {
  let button = document.getElementById("button");
  button.addEventListener('click', function(event){
    let picklist = document.getElementById("picklist");
    let value = document.getElementById("input").value;

    value = parseFloat(value);

    if (isNaN(value)) {
      alert('please enter correct number');
    }

    let result;
    switch(picklist.value) {
      case '1':
        result = value * 2.54;
        break;
      case '2':
        result = value * 0.393701;
        break;
      case '3':
        result = value * 30.48;
        break;
      case '4':
        result = value * 0.0328084;
        break;
      case '5':
        result = value * 0.9144;
        break;
      case '6':
        result = value * 1.09361;
        break;
      case '7':
        result = value * 1.609344;
        break;
      case '8':
        result = value * 0.6214;
        break;
    }

    result = result.toFixed(2);

    let output = document.getElementById('output');

    output.textContent = result;
  })

});


