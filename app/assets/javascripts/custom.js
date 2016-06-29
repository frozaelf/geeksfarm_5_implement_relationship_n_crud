$(document).ready(function () {
  $(".colorbox").colorbox();
  $.material.init();
});

function showPassword() {
    
    var key_attr = $('#password').attr('type');
    
    if(key_attr != 'text') {
        
        $('.checkbox').addClass('show');
        $('#password').attr('type', 'text');
        
    } else {
        
        $('.checkbox').removeClass('show');
        $('#password').attr('type', 'password');
        
    }
    
}
/*menu handler*/
$(function(){
  function stripTrailingSlash(str) {
    if(str.substr(-1) == '/') {
      return str.substr(0, str.length - 1);
    }
    return str;
  }

  var url = window.location.pathname;  
  var activePage = stripTrailingSlash(url);

  $('.nav li a').each(function(){  
    var currentPage = stripTrailingSlash($(this).attr('href'));

    if (activePage == currentPage) {
      $(this).parent().addClass('active'); 
    } 
  });
});

/* Article */
(function() {
  $(function() {
    return $('#articles-table').dataTable({
      processing: true,
      serverSide: true,
      ajax: $('#articles-table').data('source'),
      pagingType: 'full_numbers',
      "order": [[ 2, "desc" ]],
      columns: [
        { sortable: false, searchable: true },
        { sortable: true, searchable: true },
        { sortable: true, searchable: true },
        { sortable: false, searchable: false },
        { sortable: false, searchable: false }
      ]
    });
  });

}).call(this);
$(document).ready(function () {
$("#flowcheckall").click(function () {
        $('#articles-table tbody input[type="checkbox"]').prop('checked', this.checked);
    });
});
