/*jslint indent: 2*/
/*globals app, _, nv, d3, window*/

(function () {
  "use strict";

  if (!_.isObject(window.app) || window.app.PAGE !== "RESULT") {
    return;
  }

  var data = [{
    key: "A sua renda", values: []
  }, {
    key: "Mediana", values: []
  }];

  data[0].values.push({
    x: 300,
    y: 0
  });

  data[1].values.push({
    x: 450,
    y: 0
  });

  var chart, xDomain;

  xDomain = [0, d3.max(_.pluck(_.first(data).values, "x")) + 200];

  nv.addGraph(function() {
    chart = nv.models.scatterChart()
      .showYAxis(false)
      .showLegend(true)
      .color(d3.scale.category10().range())
      .transitionDuration(300)
      .size(function (d) {return d.x;})
      ;

    chart.sizeDomain(xDomain);
    chart.xDomain(xDomain);
    chart.xAxis.tickFormat(d3.format('.02f'));
    chart.xAxis.axisLabel("Rendas (€)");

    d3.select('#rentMedianChart svg')
        .datum(data)
        .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
}());