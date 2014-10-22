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
    
    // resolve data
    var data = [
      { "Word":"Hello", "Awesomeness":2000 },
      { "Word":"World", "Awesomeness":3000 }
    ];
    
    // update existing instance
    if (instance.chart) {
      
      instance.chart.data(data);
      instance.chart.draw();
      
    } else { // create new instance
      
      // create chart
      var svg = dimple.newSvg(el, "100%", "100%");
      var chart = new dimple.chart(svg, data);
      chart.addCategoryAxis("x", "Word");
      chart.addMeasureAxis("y", "Awesomeness");
      chart.addSeries(null, dimple.plot.bar);
      chart.draw();
      
      // save instance
      instance.chart = chart;
    }
  },
  
});