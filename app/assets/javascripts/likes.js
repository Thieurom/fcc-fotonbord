$(document).on('turbolinks:load', function() {
    $('button.foton__like').click(function(e) {
        e.stopPropagation();

        // check if user is logged in
        if ($('button.account--not-logged-in')) {
            modal.show();

        } else {
            $(this).toggleClass('foton__btn--activated');

            var $likes = $(this).siblings('.foton__likes');
            var currentContent = $likes.html();
            var isLiking;

            var count = parseInt($likes.find('.foton__likes-count').text());

            if ($(this).hasClass('foton__btn--activated')) {
                count++;
                isLiking = true;

            } else {
                count--;
                isLiking = false;
            }

            // immediately make visual changes
            $likes.html(function() {
                return '<span class="foton__likes-count">' + count + '</span>' + (count == 1 ? ' like' : ' likes');
            });

            // then send the request
            var fotonId = $(this).closest('.foton').data('foton-id');

            $.ajax({
                url: '/likes/' + fotonId + (isLiking ? '/like' : '/unlike'),
                method: 'POST'
            }).fail(function() {
                // reset the likes to before request
                $likes.html(currentContent);
            });
        }
    });
});
