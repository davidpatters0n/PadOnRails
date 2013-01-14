/**
 * Setup general info flash messages to fade out over three seconds
 */
function fadeFlash() {
    $(".notice") .animate({opacity:0}, 3000);
    $(".success").animate({opacity:0}, 3000);
    $(".info")   .animate({opacity:0}, 3000);
}

/**
 * Setup general info flash messages to begin fading in three seconds
 */
function setupFlashMessageFade() {
    /* $(".error").animate({opacity:0}, 5000); */
    /* $(".alert").animate({opacity:0}, 5000); */
    setTimeout( fadeFlash, 3000 );
}


$(document).ready(setupFlashMessageFade);
