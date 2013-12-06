/*jslint indent: 2*/
/*globals app, _, nv, d3, window*/

(function () {
  "use strict";

  if (!_.isObject(window.app) || window.app.PAGE !== "RESULT") {
    return;
  }

  var data = [{
    key: "A tua renda", values: []
  }, {
    key: "Valor médio", values: []
  }];

  var maxValue = Math.max(app.rentPrice, app.typologyMedian);
  var xDomainMaxValue = Math.floor((maxValue+150)/100)*100;

  data[0].values.push({
    x: app.rentPrice,
    y: 0,
    size: xDomainMaxValue,
    shape: 'circle'
  });

  data[1].values.push({
    x: app.typologyMedian,
    y: 0,
    size: xDomainMaxValue * 3,
    shape: 'circle'
  });

  var chart, xDomain;

  xDomain = [0, xDomainMaxValue];

  nv.addGraph(function() {
    chart = nv.models.scatterChart()
      .showYAxis(false)
      .showLegend(true)
      .color(d3.scale.category10().range())
      .transitionDuration(300)
      ;

    chart.sizeDomain(xDomain);
    chart.xDomain(xDomain);
    chart.scatter.onlyCircles(false);
    chart.xAxis.tickFormat(function (value) {
      return d3.format("f")(value) + "€";
    });

    chart.tooltipContent(function(key) {
        return '<h2>' + key + '</h2>';
    });

    d3.select('#rentMedianChart svg')
        .datum(data)
        .call(chart);

    nv.dev = false;
    nv.utils.windowResize(chart.update);

    return chart;
  });
}());
