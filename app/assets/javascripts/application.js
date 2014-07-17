// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// require turbolinks // not using turbolinks for this project
// require foundation // This is the entire foundation core, definitely not needed.
//
//= require jquery
//= require jquery_ujs
//= require ckeditor/init
//= require cocoon
//= require foundation/foundation.js
//= require foundation/foundation.topbar.js
//= require foundation/foundation.reveal.js
//= require foundation/foundation.alert.js
//= require_tree .

$(function() {
  $(document).foundation();
});
