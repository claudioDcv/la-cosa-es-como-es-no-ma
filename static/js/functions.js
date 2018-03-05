window.createFinalIndicatorEvaluation = function() {
  var createSelector = '.finalindicatorevaluation-list-create';
  var updateSelector = '.finalindicatorevaluation-list-update';
  var deleteSelector = '.finalindicatorevaluation-list-delete';

  var save = function(e) {
    e.preventDefault();
		XHRCreate({
			url: e.target.action,
			data: toJSONString(e.target),
			success: function(e) { console.log(e); window.location.reload(); },
			error: function(e) { console.log(e); },
		});
  };
  document.querySelectorAll(createSelector).forEach(function(elem) {
    elem.addEventListener('submit', save, false);
  });

  var update = function(e) {
    e.preventDefault();
		XHRUpdate({
			url: e.target.action,
			data: toJSONString(e.target),
			success: function(e) { console.log(e); window.location.reload(); },
			error: function(e) { console.log(e); },
		});
  };
  document.querySelectorAll(updateSelector).forEach(function(elem) {
    elem.addEventListener('submit', update, false);
  });

  var del = function(e) {
    e.preventDefault();
    var url = e.target.dataset.url;
    var pk = e.target.dataset.pk;
		XHRDelete({
			url: url,
			data: { pk: pk, csrfmiddlewaretoken: e.target.dataset.csrfmiddlewaretoken },
			success: function(e) { console.log(e); window.location.reload(); },
			error: function(e) { console.log(e); },
		});
  };
  document.querySelectorAll(deleteSelector).forEach(function(elem) {
    elem.addEventListener('click', del, false);
  });
};
