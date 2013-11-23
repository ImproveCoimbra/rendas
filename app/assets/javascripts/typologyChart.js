/*jslint indent: 2*/
/*globals app, _, nv, d3*/

(function () {
  "use strict";

  var DEFAULT_COLOR = "#8e8eff";
  var TYPOLOGY_LABELS = {};
  TYPOLOGY_LABELS[app.TYPOLOGIES.QUARTO] = "Quarto";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T0] = "T0";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T1] = "T1";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T2] = "T2";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T3] = "T3";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T4P] = "T4+";

  var data = [{
    key: "Renda",
    values: []
  }];

  _.each(app.TYPOLOGIES, function (typology) {
    var value;

    value = app.rentsByTipology[typology];

    if (value !== null) {
      _.first(data).values.push({
        label : TYPOLOGY_LABELS[typology] ,
        value : value,
        color: DEFAULT_COLOR
      });
    }
  });

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
    chart.yAxis.axisLabel('Renda (€)');

    chart.valueFormat(function (value) {
      return d3.format(".02f")(value) + "€";
    });

    d3.select('#typologyChart svg')
        .datum(data)
        .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
}());