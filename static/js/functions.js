window.modalMessage = function() {
  var body = document.body;
  var modalMessageCont = document.createElement('div');
  modalMessageCont.id = 'modal-message-cont';

  body.appendChild(modalMessageCont);
  
  var createModal = function() {

  }
  var show = function(message) {
    console.log(message)
  }
  var hide = function(message) {
    console.log(message)
  }

  // TODO
  return {
    modalMessageCont: modalMessageCont,
    createModel: createModal,
    show: show,
    hide: hide,
  };
};

window.createFeedback = function() {
  var createSelector = '.feedback-list-create';
  var updateSelector = '.feedback-list-update';
  var deleteSelector = '.feedback-list-delete';

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
    var code = e.target.dataset.code;
		XHRDelete({
			url: url,
			data: { code: code, pk: pk, csrfmiddlewaretoken: e.target.dataset.csrfmiddlewaretoken },
			success: function(e) { console.log(e); window.location.reload(); },
			error: function(e) { console.log(e); },
		});
  };
  document.querySelectorAll(deleteSelector).forEach(function(elem) {
    elem.addEventListener('click', del, false);
    elem.firstChild.style.pointerEvents = 'none';
  });
};

window.evaluatedEvaluatorIndex = function() {
  
  var dataScoreIndicator = document.querySelectorAll('[data-score-indicator]');
  var createSelector = '.finalindicatorevaluation-list-create';
  var updateSelector = '.finalindicatorevaluation-list-update';
  var deleteSelector = '.finalindicatorevaluation-list-delete';

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
    elem.firstChild.style.pointerEvents = 'none';
  });

    var save = function(event) {
      event.preventDefault();
      var tag = event.target;
      var form = tag.form;
      var action = form.action;
      var method = form.dataset.method;
      var value = parseInt(event.target.children[0].value);
      var create = function(event) {
        var data = toJSONString(form);
        data.value = value;
        XHRCreate({
          url: action,
          data: data,
          success: function(e) { console.log(e); window.location.reload(); },
          error: function(e) { console.log(e); },
        });
      };
      var update = function() {
        var data = toJSONString(form);
        var oldValue = data.value;
        data.value = value;
        data.oldValue = oldValue;
        var success = function(e) {
          jAlert(
            'Guardado Exitosamente el cambio de puntaje de: ',
            e.data.oldValue + ' a ' + e.value,
            function() { window.location.reload(); }, 500);
        };
        XHRUpdate({
          url: action,
          data: data,
          success: success.bind(value),
          error: function(e) { console.log(e); },
        });
      };
      switch(method) {
        case 'create':
          create();
        break;
        case 'update':
          update();
        break;
        default:
          return false;
      }
    };
  dataScoreIndicator.forEach(function(e) {
    e.addEventListener('click', save, false);
  });
}