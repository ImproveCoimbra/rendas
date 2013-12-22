/*jslint indent: 2*/
/*globals app, _, nv, d3, window*/

(function () {
  "use strict";

  if (!_.isObject(window.app) || window.app.PAGE !== "STATS") {
    return;
  }

  /*Constants*/
  var DEFAULT_COLOR = "#555";
  var TYPOLOGY_LABELS = {};
  TYPOLOGY_LABELS[app.TYPOLOGIES.QUARTO] = app.TYPOLOGIES.QUARTO;
  TYPOLOGY_LABELS[app.TYPOLOGIES.T0] = app.TYPOLOGIES.T0;
  TYPOLOGY_LABELS[app.TYPOLOGIES.T1] = app.TYPOLOGIES.T1;
  TYPOLOGY_LABELS[app.TYPOLOGIES.T2] = app.TYPOLOGIES.T2;
  TYPOLOGY_LABELS[app.TYPOLOGIES.T3] = app.TYPOLOGIES.T3;
  TYPOLOGY_LABELS[app.TYPOLOGIES.T4P] = app.TYPOLOGIES.T4P;

  //Boostrapt the data that will be used by the chart
  var data = [{
    key: "Renda",
    values: []
  }];
  _.first(data).values = _.reduce(app.TYPOLOGIES, function (memo, typology) {
    var value;

    value = app.rentsByTipology[typology];

    if (_.isNumber(value)) {
      memo.push({
        label : TYPOLOGY_LABELS[typology] ,
        value : value,
        color: DEFAULT_COLOR
      });
    }

    return memo;
  }, []);

  //Draw the chart
  nv.addGraph(function() {
    var chart = nv.models.discreteBarChart()
        .x(function(d) { return d.label; })
        .y(function(d) { return d.value; })
        .staggerLabels(false)
        .tooltips(false)
        .showValues(true)
        .transitionDuration(250)
        .margin({left: 100})
        ;

    chart.yAxis.tickFormat(d3.format(".02f"));

    chart.valueFormat(function (value) {
      return d3.format(".02f")(value) + "€";
    });

    d3.select('#typologyChart svg')
        .datum(data)
        .call(chart);

    nv.dev = false;
    nv.utils.windowResize(chart.update);

    return chart;
  });
}());
