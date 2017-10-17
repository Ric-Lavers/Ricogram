// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .

// = require jquery3
// = require popper
// = require bootstrap-sprockets
//= jquery_ujs

// To reveal more comments on the nesfeed
$(document).ready(function(){ /* to make sure the script runs after page load */
    $('.more-comments').click(function(event){ /* find all a.read_more elements and bind the following code to them */
        console.log("working");
        event.preventDefault(); /* prevent the a from changing the url */
        $(this).parents('.newsfeed-comments').find('.more_text').show(); /* show the .more_text span */
        $(this).hide();
    });
});

$(function(){
  $(".hearts").click(function(){
    $(this).toggleClass('liked');
  });
});
// $(function(){
//   $(".liked").click(function(){
//     $(this).toggleClass('hearts');
//   });
// });
