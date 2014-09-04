window.Point = (function() {
  function Point(x, y) {
    this.x = x;
    this.y = y;
  }

  return Point;

})();

window.onload = function() {
  var appendCanvas, drawLine, getCanvas, html, removeCanvas;
  html = document.getElementsByTagName("html")[0];
  html.oncontextmenu = function() {
    return false;
  };
  appendCanvas = function() {
    var canvas;
    canvas = document.createElement('canvas');
    canvas.id = 'drag-canvas';
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    canvas.setAttribute('style', "margin: 0; position: fixed; top: 0; left: 0; background: transparent");
    return html.appendChild(canvas);
  };
  removeCanvas = function() {
    var canvas;
    canvas = getCanvas();
    return canvas.parentNode.removeChild(canvas);
  };
  getCanvas = function() {
    return document.getElementById('drag-canvas');
  };
  drawLine = function(prevPoint, newPoint) {
    var canvas, context;
    canvas = getCanvas();
    context = canvas.getContext('2d');
    context.moveTo(prevPoint.x, prevPoint.y);
    context.lineTo(newPoint.x, newPoint.y);
    return context.stroke();
  };
  html.onmousedown = function(e) {
    this.finalDirection = null;
    if (e.which === 3) {
      appendCanvas();
      this.prevPoint = new Point(e.clientX, e.clientY);
      return html.onmousemove = function(e) {
        var curPoint, delta;
        curPoint = new Point(e.clientX, e.clientY);
        if (this.prevPoint != null) {
          drawLine(this.prevPoint, curPoint);
          if (this.finalDirection !== 'ambiguous') {
            delta = curPoint.x - this.prevPoint.x;
            if (delta > 0) {
              this.finalDirection = this.finalDirection === 'left' ? 'ambiguous' : 'right';
            } else if (delta < 0) {
              this.finalDirection = this.finalDirection === 'right' ? 'ambiguous' : 'left';
            }
          }
        }
        return this.prevPoint = curPoint;
      };
    }
  };
  return html.onmouseup = function() {
    if (this.finalDirection == null) {
      return false;
    }
    switch (this.finalDirection) {
      case 'left':
        window.history.back();
        break;
      case 'right':
        window.history.forward();
    }
    removeCanvas();
    return html.onmousemove = null;
  };
};
