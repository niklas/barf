// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $('a.tab').click( function() {
    $('h1.tab + div').hide();
    $( this.hash ).show();
  });
  $('a.tab:first + div').click();
});
