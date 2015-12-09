var draw = {};

draw.own = function(selection, data, scale) {

  var axis = selection.append("g").attr("class", "y axis")
    .call(d3.svg.axis().scale(scale.y).orient("left"));

  axis.selectAll("text")
    .text(function(d) { return d == 1 ? "Week 1" : d});

  var bars = selection.selectAll(".bar").data(data)
  .enter().append("rect")
    .attr("class", "bar")
    .attr("x", scale.x(0))
    .attr("y", function(d) { return scale.y(d.week); })
    .attr("width", function(d) { return scale.x(d.score); })
    .attr("height", scale.y.rangeBand())
    .style("fill", function(d) { return scale.color(d.score); });

  var x = d3.mean(data, function(d) { return d.score; });

  var line = selection.append("path")
    .datum([[scale.x(x), scale.y(1)], [scale.x(x), scale.y(13) + scale.y.rangeBand()]])
      .attr("class", "mean")
      .attr("d", d3.svg.line());

  var average = selection.append("text")
    .attr("class", "average")
    .attr("x", scale.x(x))
    .attr("y", scale.y(13) + scale.y.rangeBand())
    .attr("dy", "1.2em")
    .style("text-anchor", "middle")
    .text("Avg. " + Math.round(x));

  var labels  = selection.selectAll(".label").data(data)
    .enter().append("text")
      .attr("class", "label")
      .attr("x", function(d) { return scale.x(d.score); })
      .attr("y", function(d) { return scale.y(d.week); })
      .attr("dx", 4)
      .attr("dy", "1em")
      .text(function(d) { return d.score + (d.week == 1 ? " pts" : ""); });

};

draw.opponent = function(selection, data, scale) {
  var axis = {
    y: d3.svg.axis().scale(scale.y).orient("left")
  };

  var axis = selection.append("g").attr("class", "y axis")
    .call(d3.svg.axis().scale(scale.y).orient("left"));

  axis.selectAll("text")
    .text(function(week) {
      var opponent = data
        .filter(function(d) { return d.week == week; })[0].opponent_name;
      return opponent;
    });

  var bars = selection.selectAll(".bar").data(data)
  .enter().append("rect")
    .attr("class", "bar")
    .attr("x", scale.x(0))
    .attr("y", function(d) { return scale.y(d.week); })
    .attr("width", function(d) { return scale.x(d.opponent_score); })
    .attr("height", scale.y.rangeBand())
    .style("fill", function(d) { return scale.color(d.opponent_score); });

  var x = d3.mean(data, function(d) { return d.opponent_score; });

  var line = selection.append("path")
    .datum([[scale.x(x), scale.y(1)], [scale.x(x), scale.y(13) + scale.y.rangeBand()]])
      .attr("class", "mean")
      .attr("d", d3.svg.line());

  var average = selection.append("text")
    .attr("class", "average")
    .attr("x", scale.x(x))
    .attr("y", scale.y(13) + scale.y.rangeBand())
    .attr("dy", "1.2em")
    .style("text-anchor", "middle")
    .text("Avg. " + Math.round(x));

  var labels  = selection.selectAll(".label").data(data)
    .enter().append("text")
      .attr("class", "label")
      .attr("x", function(d) { return scale.x(d.opponent_score); })
      .attr("y", function(d) { return scale.y(d.week); })
      .attr("dx", 4)
      .attr("dy", "1em")
      .text(function(d) { return d.opponent_score + (d.week == 1 ? " pts" : ""); });

};

draw.margin = function(selection, data, scale) {
  var negatives = data
    .filter(function(d) { return d.margin < 0; })
    .map(function(d) { return d.week; });

  var axis = selection.append("g").attr("class", "y axis")
    .call(d3.svg.axis().scale(scale.y).orient("left"))
    .attr("transform", "translate(" + scale.x(0) + ",0)");

  axis.selectAll("text")
    .attr("x", function(week) { return negatives.indexOf(week) == -1 ? -9 : 9; })
    .style("text-anchor", function(week) { return negatives.indexOf(week) == -1 ? "end" : "start"; })
    .text(function(week) { return "Week " + week; });

  axis.selectAll("line")
    .attr("x2", function(week) { return negatives.indexOf(week) == -1 ? -6 : 6; });

  var bars = selection.selectAll(".bar").data(data)
  .enter().append("rect")
    .attr("class", "bar")
    .attr("x", function(d) {
      return d.margin >= 0 ? scale.x(0) : scale.x(d.margin);
    })
    .attr("y", function(d) { return scale.y(d.week); })
    .attr("width", function(d) {
      return d.margin >= 0 ?
        scale.x(d.margin) - scale.x(0) :
        scale.x(0) - scale.x(d.margin);
    })
    .attr("height", scale.y.rangeBand())
    .style("fill", function(d) { return scale.color(d.margin); });

    var x = d3.mean(data, function(d) { return d.margin; });

    var line = selection.append("path")
      .datum([[scale.x(x), scale.y(1)], [scale.x(x), scale.y(13) + scale.y.rangeBand()]])
        .attr("class", "mean")
        .attr("d", d3.svg.line());

    var average = selection.append("text")
      .attr("class", "average")
      .attr("x", scale.x(x))
      .attr("y", scale.y(13) + scale.y.rangeBand())
      .attr("dy", "1.2em")
      .style("text-anchor", "middle")
      .text("Avg. " + Math.round(x));

    var labels  = selection.selectAll(".label").data(data)
      .enter().append("text")
        .attr("class", "label")
        .attr("x", function(d) { return scale.x(d.margin); })
        .attr("y", function(d) { return scale.y(d.week); })
        .attr("dx", function(d) {
          return d.margin >= 0 ? 4 : -4;
        })
        .attr("dy", "1em")
        .style("text-anchor", function(d) {
          return d.margin >= 0 ? "start" : "end";
        })
        .text(function(d) { return d.margin + (d.week == 1 ? " pts" : ""); });
};
