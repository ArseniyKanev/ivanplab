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
//= require rails.validations
//= require ckeditor/config
//= require ckeditor/plugins/filetools/plugin
//= require ckeditor/plugins/filetools/lang/en
//= require ckeditor/plugins/uploadwidget/plugin
//= require ckeditor/plugins/uploadwidget/lang/en
//= require ckeditor/plugins/widget/plugin
//= require ckeditor/plugins/widget/lang/en
//= require_tree .

$(document).ready(function ($) {
  // browser window scroll (in pixels) after which the "back to top" link is shown
  var offset = 300,
    //browser window scroll (in pixels) after which the "back to top" link opacity is reduced
    offset_opacity = 1200,
    //duration of the top scrolling animation (in ms)
    scroll_top_duration = 700,
    //grab the "back to top" link
    $back_to_top = $(".cd-top");

  //hide or show the "back to top" link
  $(window).scroll(function () {
    $(this).scrollTop() > offset
      ? $back_to_top.addClass("cd-is-visible")
      : $back_to_top.removeClass("cd-is-visible cd-fade-out");
    if ($(this).scrollTop() > offset_opacity) {
      $back_to_top.addClass("cd-fade-out");
    }
  });

  setTimeout(() => {
    $("#notice_wrapper").fadeOut("slow", () => {
      $(this).remove();
    });
  }, 4500);

  //smooth scroll to top
  $back_to_top.on("click", function (event) {
    event.preventDefault();
    $("body,html").animate(
      {
        scrollTop: 0,
      },
      scroll_top_duration
    );
  });

  $(".cd-main-nav").on("click", function (event) {
    if ($(event.target).is(".cd-main-nav"))
      $(this).children("ul").toggleClass("is-visible");
  });
});
