$(document).on('turbolinks:load', function() {
    $('button.foton__like').click(function(e) {
        var $this = $(this);
        var $foton = $this.closest('.foton');

        e.stopPropagation();

        // check if user is logged in
        if ($('.nav__left .nav__item').length == 2) {
            var $count = $this.find('.foton__likes');
            var count = parseInt($count.text()) || 0;

            var isLiking;

            if ($this.hasClass('foton__btn--user-activated')) {
                count--;
                isLiking = false;

            } else {
                count++;
                isLiking = true;
            }

            // immediately make visual changes
            $this.toggleClass('foton__btn--user-activated');
            if (count == 0) {
                $count.text('');
            } else {
                $count.text(count);
            }

            // then send the request
            var fotonId = $foton.data('foton-id');

            $.ajax({
                url: '/likes/' + fotonId + (isLiking ? '/like' : '/unlike'),
                method: 'POST'
            }).fail(function() {
                // reset the likes to before request
                $this.toggleClass('foton__btn--user-activated');

                count = (isLiking ? count - 1 : count + 1);
                if (count == 0) {
                    $count.text('');
                } else {
                    $count.text(count);
                }
            });

        } else {
            modal.show();
        }
    });
});
