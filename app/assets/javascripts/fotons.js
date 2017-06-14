$(document).on('turbolinks:load', function() {

  // setup masonry grid layout
  $('.grid').masonry({
    itemSelector: '.grid__item',
    columnWidth: 300,
    gutter: 20,
    fitWidth: true
  });
  


  // relayout after all fotons loaded
  var $fotonImages = $('.foton-bord .foton__image');
  var count = $fotonImages.length;

  $fotonImages.on('load', function() {
    count--;

    if (!count) {
      $('.grid').masonry();
    }
  });



  // zoom in on foton
  $('.foton-bord .card').click(function() {

    // determine the display size
    var fotonUrl = $(this).find('.foton__image').attr('src');

    var $image = $('<img/>', { 'class': 'zoom-foton__image' })
      .on('load', function() {
        var w = $(this).width();
        var h = $(this).height();

        if (w > h) {

          $(this).css({
            'width': Math.min(w, $(window).width() - 100) + 'px',
            'height': h + 'px'
          });

        } else {

          $(this).css({
            'width': w + 'px',
            'height': Math.min(h, $(window).height() - 100) + 'px'
          });
        }
      });

    $image.attr('src', fotonUrl);


    // add modal to DOM
    var $zoomFoton = $('<div/>', { 'class': 'zoom-foton' });

    $zoomFoton.click(function(e) {
      e.stopPropagation();

      if ($(e.target).hasClass('zoom-foton')) {
        $(this).remove();
        $('body').removeClass('no-scroll');
      }
    });

    var $zoomDismiss = $('<button/>', { 'class': 'zoom-dismiss' }).append($('<i/>', { 'class': 'fa fa-times' }));

    $zoomDismiss.click(function() {
      $(this).closest('.zoom-foton').remove();
      $('body').removeClass('no-scroll');
    });


    $zoomFoton.append($zoomDismiss)
      .append($('<div/>', { 'class': 'zoom-foton__wrapper' }).append($image))
      .appendTo($('body'));

    $('body').addClass('no-scroll');
  });
});
