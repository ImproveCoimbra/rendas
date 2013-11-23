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
    x: app.rentPrice,
    y: 0
  });

  data[1].values.push({
    x: app.typologyMedian,
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
    chart.xAxis.tickFormat(function (value) {
      return d3.format("f")(value) + "€";
    });
    chart.xAxis.axisLabel("Rendas (€)");

    chart.tooltipContent(function(key) {
        return '<h2>' + key + '</h2>';
    });

    d3.select('#rentMedianChart svg')
        .datum(data)
        .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
}());