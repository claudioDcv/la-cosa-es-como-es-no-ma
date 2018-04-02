var colorArray = ['#FF6633', '#FFB399', '#FF33FF', '#FFFF99', '#00B3E6', 
  '#E6B333', '#3366E6', '#999966', '#99FF99', '#B34D4D',
  '#80B300', '#809900', '#E6B3B3', '#6680B3', '#66991A', 
  '#FF99E6', '#CCFF1A', '#FF1A66', '#E6331A', '#33FFCC',
  '#66994D', '#B366CC', '#4D8000', '#B33300', '#CC80CC', 
  '#66664D', '#991AFF', '#E666FF', '#4DB3FF', '#1AB399',
  '#E666B3', '#33991A', '#CC9999', '#B3B31A', '#00E680', 
  '#4D8066', '#809980', '#E6FF80', '#1AFF33', '#999933',
  '#FF3380', '#CCCC00', '#66E64D', '#4D80CC', '#9900B3', 
  '#E64D66', '#4DB380', '#FF4D4D', '#99E6E6', '#6666FF'];
var backgroundColor = [
  'rgba(255, 99, 132, 0.6)',
  'rgba(54, 162, 235, 0.6)',
  'rgba(255, 206, 86, 0.6)',
  'rgba(75, 192, 192, 0.6)',
  'rgba(153, 102, 255, 0.6)',
  'rgba(255, 159, 64, 0.6)'];
var borderColor = [
    'rgba(255,99,132,1)',
    'rgba(54, 162, 235, 1)',
    'rgba(255, 206, 86, 1)',
    'rgba(75, 192, 192, 1)',
    'rgba(153, 102, 255, 1)',
    'rgba(255, 159, 64, 1)'];

var materialColor = [
  'ff0029', '377eb8', '66a61e', '984ea3', '00d2d5', 'ff7f00', 'af8d00',
  '7f80cd', 'b3e900', 'c42e60', 'a65628', 'f781bf', '8dd3c7', 'bebada',
  'fb8072', '80b1d3', 'fdb462', 'fccde5', 'bc80bd', 'ffed6f', 'c4eaff',
  'cf8c00', '1b9e77', 'd95f02', 'e7298a', 'e6ab02', 'a6761d', '0097ff',
  '00d067', '000000', '252525', '525252', '737373', '969696', 'bdbdbd',
  'f43600', '4ba93b', '5779bb', '927acc', '97ee3f', 'bf3947', '9f5b00',
  'f48758', '8caed6', 'f2b94f', 'eff26e', 'e43872', 'd9b100', '9d7a00',
  '698cff', 'd9d9d9', '00d27e', 'd06800', '009f82', 'c49200', 'cbe8ff',
  'fecddf', 'c27eb6', '8cd2ce', 'c4b8d9', 'f883b0', 'a49100', 'f48800',
  '27d0df', 'a04a9b'
];

var customColors = ['#7166ba', '#ea4e4f', '#64c450', '#f9d733', '#4db7e8'];
// HELPERS
function randArrayValue(arr) {
  var rand = arr[Math.floor(Math.random() * arr.length)];
  return rand;
}

// FUNCTIONS
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
            'Guardado',
            'Cambio puntaje de ' + e.data.oldValue + ' a ' + e.value,
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
};

window.startSkills = function(data) {
  var w = 200;
  var h = 200;
  var elm = document.getElementById('skills');
  var skillMargin = 15;

  elm.style.height = h + 'px';
  
  var cont = document.createElement('div');

  var innerH = h - (skillMargin * 2);
  var spacingPercentVal = innerH / 10;

  var perecentValueCont = document.createElement('div');
  for(var i = 0; i < 11; i++) {
    var perecentValue = document.createElement('div');
    perecentValue.className = 'percent-value';
    perecentValue.style.bottom = (skillMargin + (spacingPercentVal * i)) + 'px';
    perecentValueCont.appendChild(perecentValue);
  }
  cont.appendChild(perecentValueCont);
  elm.appendChild(cont);

  cont.style.width = (data.length * w + (skillMargin * (data.length - 1))) + 'px'; cont.style.height = '100%'; cont.style.display = 'inline-block';

  // create skills container
  data.forEach(function (element, index){
    var skill = document.createElement('div');
    var skillPercent = document.createElement('div');

    var containerPercentText = document.createElement('div');

    var percentText = document.createTextNode(
      (Math.floor(element.percent * 10) / 10) + '%'
    );
    
    var containerDescriptionText = document.createElement('a'); 
    containerDescriptionText.href = '#skill-' + element.object.id;
    containerDescriptionText.className = 'btn btn-link d-block w-100';
    containerDescriptionText.style.position = 'absolute'; containerDescriptionText.style.bottom = 0; containerDescriptionText.style.left = 0;

    var descriptionText = document.createTextNode(element.object.name);

    skillPercent.style.width = w + 'px'; skillPercent.style.height = element.percent + '%'; 
    skillPercent.style.position = 'absolute'; skillPercent.style.bottom = 0; skillPercent.style.left = 0;
    skillPercent.style.backgroundColor = randArrayValue(customColors);
    skillPercent.className = 'percent-bar';

    skill.style.width = w + 'px'; skill.style.height = '100%'; skill.style.float = 'left'; skill.style.position = 'relative';

    if (index < data.length - 1) {
      skill.style.marginRight = skillMargin + 'px';
    }

    containerDescriptionText.appendChild(descriptionText);
    skillPercent.appendChild(containerDescriptionText);

    containerPercentText.appendChild(percentText);
    skillPercent.appendChild(containerPercentText);

    skill.appendChild(skillPercent);

    cont.appendChild(skill);
  });
};