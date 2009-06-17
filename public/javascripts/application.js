// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $('a.tab').click( function() {
    $('div.tab').hide();
    $('a.tab').removeClass('selected');
    $(this).addClass('selected');
    $( 'div' + this.hash).show();
    return false;
  });
  $('a.tab:first').click();
});
