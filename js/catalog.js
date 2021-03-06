/**
 * Forms Search using Twitter Typeahead. Prefetch all accessible forms
 * for the Kapp.
**/
$(function(){
  if (!$('.navbar-form .typeahead').length){
    return;
  }
  var matcher = function(strs) {
    return function findMatches(query, callback) {
        var matches, substringRegex;
        matches = [];
        substrRegex = new RegExp(query, 'i');
        $.each(strs, function(i, str) {
          if (substrRegex.test(str)) {
            matches.push(str);
          }
        });
        callback(matches);
    };
  };
  var formNames = [];
  var forms = {};
  $.get(window.bundle.apiLocation() + "/kapps/" + window.bundle.kappSlug() + "/forms", function( data ) {
    forms = data.forms;
    $.each(forms, function(i,val) {
      formNames.push(val.name);
      forms[val.name] = val;
    });
  });
  $('.navbar-form .typeahead').typeahead({
      highlight:true
    },{
      name: 'forms',
      source: matcher(formNames),
    }).bind('typeahead:select', function(ev, suggestion) {
      window.location.replace(window.bundle.kappLocation() + "/" + forms[suggestion].slug)
  });
});


$(function(){
	// Ajax call to get HTML that builds the submissions table via a callback
	$.ajax({
	  method: 'get',
	  url: '?partial=submissions.json',
	  data: {"submissionType":"Submissions"},
	  success: function(data, textStatus, jqXHR){
		  // Create DataTable for Object
		  $.each(data.data, function(index, datum){
			if(datum["fa-logo"] != undefined){
				datum["label"] = "<i class='fa " + datum["fa-logo"] + "'></i>&nbsp;&nbsp;" + datum["label"];
			}
		  });
		  var submissionsTable = $('#submissionsTable').DataTable(data);

		  // On click Function for Row Buttons
		  $('#submissionsTable tbody').on('click', 'tr', function (evt) {
			window.location.href=bundle.kappLocation() + "?submission_id=" + this.id;
		  });
		  
	  },
	  dataType: "json",
	  error: function(jqXHR, textStatus, errorThrown){
		  $('#submissionsTable').html('<b>Error fetching Submissions for the </b>');
	  }
	});
  
	$.ajax({
		method:		'get',
		url:		'?partial=submissions.json',
		data:		{"submissionType":	"Approvals"},
		dataType:	'json',
		success:	function(data, textStatus, jqXHR){
			// Create DataTable for Object
			var approvalsTable = $('#assignedTasksTable').DataTable(data);

			// On click Function for Row Buttons
			$('#assignedTasksTable tbody').on( 'click', 'tr', function () {
				window.location.href=bundle.spaceLocation() + "/submissions/" + this.id;
			});
		},
		error:		function(jqXHR, textStatus, errorThrown){
			$("#assignedTasksTable").html("Error fetching approvals");
		}
	});
});

/**
 * Applies the Jquery DataTables plugin to a rendered HTML table to provide
 * column sorting and Moment.js functionality to date/time values.
 *
 * @param {String} tableId The id of the table element.
 * @returns {undefined}
 */
function submissionsTable (tableId) {
    $('#'+tableId).DataTable({
        dom: '<"wrapper">t',
        columns: [ { defaultContent: ''}, null, null, null, null ],
        columnDefs: [
            {
                render: function ( cellData, type, row ) {
                    var span = $('<a>').attr('href', 'javascript:void(0);');
                    var iso8601date = cellData;
                    $(span).text(moment(iso8601date).fromNow())
                            .attr('title', moment(iso8601date).format('MMMM Do YYYY, h:mm:ss A'))
                            .addClass('time-ago')
                            .data('toggle', 'tooltip')
                            .data('placement', 'top');
                    var td = $('#'+tableId+' td:contains('+cellData+')');
                    td.html(span);
                    return td.html();
                },
                targets: 'date'
            },
            {
                orderable: false,
                targets: 'nosort'
            }
        ]
    });
}
