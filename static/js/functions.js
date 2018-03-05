window.createFinalIndicatorEvaluation = function() {
  var createSelector = '.finalindicatorevaluation-list-create';
  var updateSelector = '.finalindicatorevaluation-list-update';

  var save = function(e) {
    e.preventDefault();
    var data = toJSONString(e.target);
		XHRCreate({
			url: e.target.action,
			data: data,
			success: function(e) { console.log(e); window.location.reload(); },
			error: function(e) { console.log(e); },
		});
  };
  document.querySelectorAll(createSelector).forEach(function(elem) {
    elem.addEventListener('submit', save, false);
  });

  var update = function(e) {
    e.preventDefault();
    var data = toJSONString(e.target);
		XHRUpdate({
			url: e.target.action,
			data: data,
			success: function(e) { console.log(e); window.location.reload(); },
			error: function(e) { console.log(e); },
		});
  };
  document.querySelectorAll(updateSelector).forEach(function(elem) {
    elem.addEventListener('submit', update, false);
  });
};
