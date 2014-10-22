HTMLWidgets.widget({

  name: "dimple",

  type: "output",

  initialize: function(el, width, height) { 
    return {};
  },

  resize: function(el, width, height, instance) {
    if (instance.chart)
      instance.chart.draw(0, true);
  },

  renderValue: function(el, x, instance) {
    
    // alias/resolve options and data
    var options = x.options;
    var data = HTMLWidgets.dataframeToD3(x.data);
    
    // update existing instance
    if (instance.chart) {
      
      instance.chart.data = data;
      instance.chart.draw();
      
    } else { // create new instance
      
      // create chart
      var svg = dimple.newSvg(el, "100%", "100%");
      var chart = new dimple.chart(svg, data);
      
      // auto-axes and series
      this.addAxis(chart, options.auto.xAxis); 
      this.addAxis(chart, options.auto.yAxis);
      this.addSeries(chart, options.auto.series);
         
      // draw the chart
      chart.draw();
      
      // save instance
      instance.chart = chart;
    }
  },
  
  addAxis: function(chart, axis) {
    
    var ax = chart.addAxis(axis.position,
                           axis.categoryFields,
                           axis.measure,
                           axis.timeField);
   
    ax.title = axis.title;
    
    return ax;
  },
  
  addSeries: function(chart, series) {
    
    // determine plot function
    var plotFunction = null;
    if (series.plotFunction == "bubble")
      plotFunction = dimple.plot.bubble;
    else if (series.plotFunction == "bar")
      plotFunction = dimple.plot.bar;
    else if (series.plotFunction == "line")
      plotFunction = dimple.plot.line;
    else if (series.plotFunction == "area")
      plotFunction = dimple.plot.area;
    else
      throw "Invalid series type: " + series;

    // add series
    return chart.addSeries(series.categoryFields, plotFunction, series.axes);   
  }
  
});