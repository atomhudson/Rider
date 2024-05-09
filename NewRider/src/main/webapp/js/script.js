$(document).ready(function() {
    var data = [];
    $.getJSON('http://localhost:7070/NewRider/json/cities.json', function(result) {
        $.each(result, function(index, val) {
            data.push(val);
        });
        console.log(data);
        $("#departure").autocomplete({
            source: data
        });
        $("#destination").autocomplete({
            source: data
        });
    });
});
