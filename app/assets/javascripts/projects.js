$(document).ready(function() {
    $("#owner a.add_fields").
      data("association-insertion-method", 'append').
      data("rewards", 'this');
});