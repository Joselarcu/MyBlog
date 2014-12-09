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
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require_tree .



//$(document).ready(function(){
  //$("#blog_title").hover(function(){
    //$("#blog_title").animate({
      //opacity: 0.25
    //});
  //},function(){
    //$("#blog_title").animate({
      //opacity: 1
    //});
  //});
//});


//function to rotate the image
//$(document).ready(function(){
//  $(".img-circle").hover(function(){
//    $('.img-circle').toggleClass('rotate')
//  });
//});

$(document).ready(function(){
  $('#option2').click(function(){
    $(this).addClass('active');
    $('#option3').removeClass('active');
    $('#option4').removeClass('active');
  });
  $('#option3').click(function(){
    $(this).addClass('active');
    $('#option2').removeClass('active');
    $('#option4').removeClass('active');
  });
  $('#option4').click(function(){
    $(this).addClass('active');
    $('#option2').removeClass('active');
    $('#option3').removeClass('active');
  });
});

$(document).ready(function () {
  var page = document.location.href.split('/').slice(-1)[0];
  if(page == 'contact'){
    $('#option2').addClass('active');
  }else if(page == 'projects'){
    $('#option3').addClass('active')
  }
  else{
  }
});