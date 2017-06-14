$(document).on('turbolinks:load', function() {

  // display modal
  $('.add-foton-btn, .account--not-logged-in').click(function(e) {
    e.preventDefault();
    $('.modal').addClass('modal--shown');
    $('body').addClass('no-scroll');
  });


  // hide modal
  $('.modal__dismiss').click(function() {
    $('.modal').removeClass('modal--shown');
    $('body').removeClass('no-scroll');
    resetForm();
  });

  $('.modal').click(function(e) {
    e.stopPropagation();

    if ($(e.target).hasClass('modal--shown')) {
      $(this).removeClass('modal--shown');
      $('body').removeClass('no-scroll');
      resetForm();
    }
  });


  // preview image from source input
  $('input#source').change(function() {
    var fotonUrl = $(this).val();

    // create a temporary image element
    $('<img />')
      .on('error', function() {
        $('.new-foton__previewer')
          .removeClass('new-foton__previewer--no-source')
          .addClass('new-foton__previewer--bad-source')
          .removeAttr('style')
      })
      .on('load', function() {
        $('.new-foton__previewer')
          .removeClass('new-foton__previewer--no-source')
          .removeClass('new-foton__previewer--bad-source')
          .css('background-image', 'url(' + fotonUrl + ')');
      })
      .attr('src', fotonUrl);
  });


  // supporting function
  function resetForm() {
    if ($('.form')[0]) {
      $('.form')[0].reset();
      $('.new-foton__previewer')
        .removeClass('new-foton__previewer--bad-source')
        .addClass('new-foton__previewer--no-source');
    }
  }
});
