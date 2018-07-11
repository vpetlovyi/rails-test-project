// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

Turbolinks.scroll = {};

$(document).on('click', '[data-turbolinks-scroll=false]', function (e) {
    Turbolinks.scroll['top'] = {
        html: $("html").scrollTop(),
        body: $("body").scrollTop()
    }
});

$(document).on('turbolinks:load', function() {
    if (Turbolinks.scroll['top']) {
        $('html').scrollTop(Turbolinks.scroll['top']['html']);
        $('body').scrollTop(Turbolinks.scroll['top']['body']);
    }
    Turbolinks.scroll = {};
});
