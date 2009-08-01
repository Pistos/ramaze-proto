function hide_shortly( thing ) {
    setTimeout( function() {
        thing.slideUp();
    }, 5000 );
}

function show_result_messages( json ) {
    if( json.error ) {
        $( '#message-error' ).text( json.error ).slideDown();
        hide_shortly( $( '#message-error' ) );
    }
    if( json.success && json.success != true ) {
        $( '#message-success' ).text( json.success ).slideDown();
        hide_shortly( $( '#message-success' ) );
    }
}

function slideUp_tr( tr ) {
    tr.children( 'td' ).each( function() {
        var td = $(this);
        td.wrapInner("<div></div>").children( "div" ).slideUp();
        td.animate(
            { paddingTop: '0px', paddingBottom: '0px', },
            'normal',
            function() {
                if( $.browser.opera ) {
                    tr.remove();
                } else {
                    td.css( 'border', '0px' );
                }
            }
        );
    });
};

function add_spinner_to( target ) {
    target.append( '<img src="/images/spinner.gif" alt="..." class="spinner"/>' );
};

function add_spinner_beside( target ) {
    target.after( '<img src="/images/spinner.gif" alt="..." class="spinner"/>' );
};

