// global objects
var modal;
var fotonZoomer;
var $grid;



$(document).on('turbolinks:load', function() {

    // setup masonry grid layout
    $grid = $('.foton-bord .grid');
    $grid.masonry({
        itemSelector: '.grid__item',
        columnWidth: 305,
        gutter: 20,
        fitWidth: true
    });

    // =======================================================================



    // modal wrapper object
    modal = (function() {

        var $modal = $('.modal');
        var $dismiss = $modal.find('.modal__dismiss');
        var cb = null;

        $dismiss.click(function() {
            modal.dismiss();
        });

        $modal.click(function(e) {
            e.stopPropagation();

            if ($(e.target).hasClass('modal--shown')) {
                modal.dismiss();
            }
        });

        return {
            show: function(dismissCallback) {
                $modal.addClass('modal--shown');
                $('body').addClass('no-scroll');
                cb = dismissCallback;
            },

            dismiss: function() {
                $('.modal').removeClass('modal--shown');
                $('body').removeClass('no-scroll');
                if (cb && typeof cb === 'function') cb();
                cb = null;
            }
        };
    })();


    // display modal for login
    $('a#login').click(function(e) {
        e.preventDefault();
        modal.show();
    });


    // display modal for creating new foton
    $('.header .button--primary').click(function() {
        modal.show(function() {
            var form = $('.form')[0];

            if (form) {
                // clear input's content
                form.reset();

                // reset previewer
                $(form).find('.new-foton__previewer')
                    .removeClass('new-foton__previewer--bad-source')
                    .addClass('new-foton__previewer--no-source')
                    .removeAttr('style');

                // remove errors if any
                $(form).find('.form__error').remove();
                $(form).find('.form__input').removeClass('form__input--error');
            }
        });
    });

    // =======================================================================



    // preview image from source input
    $('input#foton_source').change(function() {
        var fotonUrl = $(this).val();

        if ((/^https?:\/\//).test(fotonUrl)) {
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
        } else {
            $('.new-foton__previewer')
                .removeClass('new-foton__previewer--no-source')
                .addClass('new-foton__previewer--bad-source')
                .removeAttr('style')
        }
    });

    // =======================================================================



    // load fotons from external sources
    var $fotonImages = $('.foton-bord .foton__image');
    var count = $fotonImages.length;

    $fotonImages.each(function() {
        var $this = $(this);

        $this.on('load', function() {
            var width = $this[0].naturalWidth;
            var height = $this[0].naturalHeight;
            var caption = $this.data('caption');

            $this.attr('data-natural-width', width);
            $this.attr('data-natural-height', height);
            $this.attr('alt', caption);

            $this.removeAttr('data-src');
            $this.removeAttr('data-caption');
            $this.removeAttr('style');


            count--;

            // relayout after all fotons loaded
            if (!count) {
                $grid.masonry();
            }
        }).on('error', function() {
            $this.addClass('foton__image--broken');
        });

        $this.attr('src', $this.data('src'));
    });

    // =======================================================================



    //foton zoomer
    fotonZoomer = (function() {

        var foton = null;

        var $zoomer = $('<div class="zoom-foton" />');

        var $dismiss = $('<button class="zoom-dismiss"><i class="fa fa-times"></i></button>');

        var $image = $('<img class="zoom-foton__image" />')
            .on('load', function() {
                var w = foton.width;
                var h = foton.height;
                var MAX_ZOOM_SIZE = 580;

                if (w < MAX_ZOOM_SIZE && h < MAX_ZOOM_SIZE) {
                    $(this).css({
                        'width': w + 'px',
                        'height': h + 'px'
                    });

                } else {
                    if (w > h) {
                        $(this).css({
                            'width': MAX_ZOOM_SIZE + 'px',
                            'height': 'auto'
                        });

                    } else {
                        $(this).css({
                            'height': MAX_ZOOM_SIZE + 'px',
                            'width': 'auto'
                        });
                    }
                }
            });


        $zoomer.append($dismiss, $('<div class="zoom-foton__wrapper" />').append($image));


        $zoomer.click(function(e) {
            e.stopPropagation();

            if ($(e.target).hasClass('zoom-foton')) {
                fotonZoomer.dismiss();
            }
        });


        $dismiss.click(function() {
            fotonZoomer.dismiss();
        });


        return {
            zoom: function(source) {
                foton = source;

                // start loading image
                $image.attr('src', foton.url);

                // add zoomer to DOM
                $zoomer.appendTo($('body'));
                $('body').addClass('no-scroll');
            },

            dismiss: function() {
                $zoomer.detach();
                $('body').removeClass('no-scroll');
                foton = null;
            }
        };
    })();



    // zoom in on foton
    $('.foton-bord .card').click(function() {
        var $image = $(this).find('.foton__image');

        var url = $image.attr('src');
        var width = $image.data('natural-width');
        var height = $image.data('natural-height');

        fotonZoomer.zoom({ url: url, width: width, height: height });
    });

    // =======================================================================



    // creating new foton
    $('.form').on('submit', function() {
        // remove errors if any
        $(this).find('.form__error').remove();
        $(this).find('.form__input').removeClass('form__input--error');

        // temporarily hide the form
        $(this).closest('.modal').removeClass('modal--shown');

        // add freeze overlay on top of page
        $('<div class="freeze-overlay"><div class="spinner"><i class="fa fa-spinner"></i></div></div>').appendTo('body');

    }).on('ajax:error', function() {
        // show the form again
        $(this).closest('.modal').addClass('modal--shown');

        // remove freeze overlay
        $('.freeze-overlay').remove();
    });

    // =======================================================================



    // link current foton to user's bord
    $('button.foton__link').click(function(e) {
        var $this = $(this);

        e.stopPropagation();

        // check if user is logged in
        if ($('.nav__left .nav__item').length == 2) {
            $this.addClass('foton__btn--user-activated');

            var fotonId = $this.closest('.foton').data('foton-id');
            $.ajax({
                url: '/fotons/' + fotonId,
                method: 'PATCH'
            }).fail(function() {
                $this.removeClass('foton__btn--user-activated');
            });

        } else {
            modal.show();
        }
    });


    // unlink current foton from user's bord
    $('button.foton__unlink').click(function(e) {
        var $this = $(this);

        e.stopPropagation();

        if ($('.nav__left .nav__item').length == 2) {
            var fotonId = $this.closest('.foton').data('foton-id');

            $.ajax({
                url: '/fotons/' + fotonId,
                method: 'DELETE'
            }).done(function() {
                $grid.masonry('remove', $this.closest('.grid__item'))
                    .masonry('layout');
            });

        } else {
            modal.show();
        }
    });
});
