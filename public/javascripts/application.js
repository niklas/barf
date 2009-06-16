// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $('a.tab').click( function() {
    console.debug("clicked", this.hash);
    $('h1.tab + div').hide();
    $( this.hash + ' + div').show();
  });
  $('a.tab:first').click();
});
