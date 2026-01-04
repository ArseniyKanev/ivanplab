//= require jquery
//= require jquery_ujs
//= require rails.validations
//= require froala_editor.min.js
//= require plugins/align.min.js
//= require plugins/char_counter.min.js
//= require plugins/code_beautifier.min.js
//= require plugins/code_view.min.js
//= require plugins/colors.min.js
//= require plugins/emoticons.min.js
//= require plugins/entities.min.js
//= require plugins/file.min.js
//= require plugins/font_family.min.js
//= require plugins/font_size.min.js
//= require plugins/fullscreen.min.js
//= require plugins/help.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require plugins/inline_class.min.js
//= require plugins/inline_style.min.js
//= require plugins/line_breaker.min.js
//= require plugins/line_height.min.js
//= require plugins/link.min.js
//= require plugins/lists.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/paragraph_style.min.js
//= require plugins/print.min.js
//= require plugins/quote.min.js
//= require plugins/save.min.js
//= require plugins/table.min.js
//= require plugins/special_characters.min.js
//= require plugins/url.min.js
//= require plugins/video.min.js
//= require languages/ru.js
//= require third_party/embedly.min.js
//= require third_party/font_awesome.min.js
//= require third_party/image_tui.min.js
//= require third_party/spell_checker.min.js

//= require_tree .

$(document).ready(function ($) {
  var offset = 300,
    offset_opacity = 1200,
    scroll_top_duration = 700,
    $back_to_top = $(".cd-top");

  $(window).scroll(function () {
    $(this).scrollTop() > offset
      ? $back_to_top.addClass("cd-is-visible")
      : $back_to_top.removeClass("cd-is-visible cd-fade-out");
    if ($(this).scrollTop() > offset_opacity) {
      $back_to_top.addClass("cd-fade-out");
    }
  });

  setTimeout(() => {
    $("#notice_wrapper").fadeOut(300, () => {
      $(this).remove();
    });
  }, 2500);

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


  $('.file-input').on('change', function () {
    var fileName = $(this).val().split('\\').pop();
    var $fileDisplay = $(this).closest('.inline-form').find('.file-name-display');
    var $fileLabel = $(this).closest('.inline-form').find('.file-label-text');

    if (fileName) {
      $fileDisplay.text(fileName).css({
        'margin-left': '8px',
        'font-size': '13px',
        'color': '#666',
        'max-width': '200px',
        'overflow': 'hidden',
        'text-overflow': 'ellipsis',
        'white-space': 'nowrap'
      });
      $fileLabel.text('Change File');
    } else {
      $fileDisplay.text('');
      $fileLabel.text('Choose File');
    }
  });
});
