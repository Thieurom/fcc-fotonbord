$(document).on('turbolinks:load', function() {

  // display modal
  $('.add-foton-btn').on('click', function(e) {
    e.preventDefault();
    $('.modal').addClass('modal--shown');
  });


  $('.account--not-logged-in').on('click', function(e) {
    e.preventDefault();
    $('.modal').addClass('modal--shown');
  });

  // hide modal
  $('.modal__dismiss').on('click', function() {
    $('.modal').removeClass('modal--shown');
  });

  $('.modal').on('click', function(e) {
    e.stopPropagation();
    if ($(e.target).hasClass('modal--shown')) {
      $('.modal').removeClass('modal--shown');
    }
  });
});
