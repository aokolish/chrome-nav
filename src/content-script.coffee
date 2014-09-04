class window.Point
  constructor: (@x, @y) ->

window.onload = ->
  html = document.getElementsByTagName("html")[0]

  # how to do this dynamically
  html.oncontextmenu = -> false

  appendCanvas = ->
    canvas = document.createElement('canvas')
    canvas.id = 'drag-canvas'
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
    canvas.setAttribute 'style', "margin: 0; position: fixed; top: 0; left: 0; background: transparent"
    html.appendChild canvas

  removeCanvas = ->
    canvas = getCanvas()
    canvas.parentNode.removeChild(canvas)

  getCanvas = ->
    document.getElementById('drag-canvas')

  drawLine = (prevPoint, newPoint) ->
    canvas = getCanvas()
    context = canvas.getContext '2d'
    context.moveTo(prevPoint.x, prevPoint.y)
    context.lineTo(newPoint.x, newPoint.y)
    context.stroke()

  html.onmousedown = (e) ->
    @finalDirection = null
    if e.which == 3
      appendCanvas()
      @prevPoint = new Point e.clientX, e.clientY
      html.onmousemove = (e) ->
        curPoint = new Point e.clientX, e.clientY
        if @prevPoint?
          drawLine(@prevPoint, curPoint)
          unless @finalDirection == 'ambiguous'
            delta = curPoint.x - @prevPoint.x
            if delta > 0
              @finalDirection = if @finalDirection is 'left' then 'ambiguous' else 'right'
            else if delta < 0
              @finalDirection = if @finalDirection is 'right' then 'ambiguous' else 'left'
        @prevPoint = curPoint

  html.onmouseup = ->
    unless @finalDirection?
      return false

    switch @finalDirection
      when 'left' then window.history.back()
      when 'right' then window.history.forward()
    removeCanvas()
    html.onmousemove = null
