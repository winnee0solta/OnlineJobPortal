const mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

mix.js('resources/js/app.js', 'public/js')
    .sass('resources/sass/app.scss', 'public/css');


    // mix.js("resources/js/dashboard/app.js", "public/js/dashboard/v1_app.js")
    // .js("resources/js/site/app.js", "public/js/site/v1_app.js")
    // .sass(
    //     "resources/sass/dashboard/app.scss",
    //     "public/css/dashboard/v1_app.css"
    // )
    // .sass("resources/sass/site/app.scss", "public/css/site/v1_app.css");

mix.browserSync({
    proxy: "http://localhost:8000",
    snippetOptions: {
        rule: {
            match: /<\/body>/i,
            fn: function(snippet, match) {
                return snippet + match;
            }
        }
    }
});

//for notification
mix.disableNotifications();

