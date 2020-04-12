
require('daemonite-material');


$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();

    var $window = $(window);
    var windowsize = $window.width();

    // //Hide drawer if less width
    // if (windowsize < 850) {
    //     $("#navdrawerDefault").removeClass("navdrawer-permanent");
    //     $("#navdrawerDefault").removeClass("navdrawer-permanent-clipped");
    //     $("#drawer_switcher").show();
    // }else{
    //     // $("#navdrawerDefault").removeClass("navdrawer-permanent");
    //      $("#drawer_switcher").hide();
    // }
});

