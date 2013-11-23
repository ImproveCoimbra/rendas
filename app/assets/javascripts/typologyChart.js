/*jslint indent: 2*/
/*globals app, _, nv, d3*/

(function () {
  "use strict";

  /*Constants*/
  var DEFAULT_COLOR = "#8e8eff";
  var TYPOLOGY_LABELS = {};
  TYPOLOGY_LABELS[app.TYPOLOGIES.QUARTO] = "Quarto";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T0] = "T0";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T1] = "T1";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T2] = "T2";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T3] = "T3";
  TYPOLOGY_LABELS[app.TYPOLOGIES.T4P] = "T4+";
  var Y_AXIS_LABEL = 'Rendas (€)';

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
    chart.yAxis.axisLabel(Y_AXIS_LABEL);

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