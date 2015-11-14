// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require turbolinks
//= require_tree .



$(document).on('ready page:load', function () {
  $(".toggleNav").click(function () {
      $("#subnav").toggleClass("active");
      $(".toggleNavButton").toggleClass("active");
   });

  $("#mobile_nav").click(function(){

    //toggles nav and ensures other elements play nice too
    if($("#primary_nav").css('left') < "0px"){
      $("#primary_nav").animate({left: "0px"}, 200);
      $("#wrapper_main_content").animate({left: "150px"}, 200);
      $("#wrapper_main_content").css("overflow-y","hidden");
      $("body").css("overflow-x","hidden");
      $("#primary_nav").css("overflow-y","auto");
    }else{
      $("#primary_nav").animate({left: "-115px"}, 200);
      $("#wrapper_main_content").animate({left: "0px"}, 200);
      $("#wrapper_main_content").css("overflow-y","auto");
      $("body").css("overflow-x","hidden");

    }

  });
    var monkeyList = new List('test-list', {
      valueNames: ['name'],
      plugins: [ ListFuzzySearch() ]
    });

});

