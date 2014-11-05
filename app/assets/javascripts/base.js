$(document).ready(function() {
  if ( $(".flash-error, .flash-success, .flash-notice").length === 0 ) {
    $(".wrapper-for-content-outside-of-footer").css("min-height", "calc(100% - 60px - 4em)");
  } else {
    $(".wrapper-for-content-outside-of-footer").css("min-height", "calc(100% - 60px - 4em - 48px)");
  }
});