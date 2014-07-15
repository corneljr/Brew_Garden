$(document).ready(function() {
    $("#new_project a.add_fields").
      data("association-insertion-method", 'append').
      data("rewards", 'this');
});