# hello


@LiteBrite = class LiteBrite


  constructor: (settings) ->
    defaults =
      data:           []
      transform:      []
      cameraDistance: 30
      size:           0.15
      width:          500
      height:         500
      fog:            null
      cameraRotateSpeed: 0.0003

    @settings = $.extend true, {}, defaults, settings
    
    @addPoints()


  initThreeJS: ->
    @renderer = new THREE.WebGLRenderer(antialias: true)
    @renderer.setSize @settings.width, @settings.height
    $("#canvas")[0].appendChild @renderer.domElement
    @scene = new THREE.Scene()
    @scene.fog = @settings.fog


  generateVertexBuffer: (len) ->
    geometry = new THREE.BufferGeometry()
    geometry.attributes =
      position:
        itemSize: 3
        array: new Float32Array(len * 3)
        numItems: len * 3
      color:
        itemSize: 3
        array: new Float32Array(len * 3)
        numItems: len * 3
    geometry


  addPoints: =>
    @initThreeJS()
    geometry = @generateVertexBuffer @settings.data.length
    positions = geometry.attributes.position.array
    colors = geometry.attributes.color.array

    
    for p,i in @settings.data
      p2 = p
      for transform in @settings.transform
        p2 = transform p2

      positions[ i*3...i*3+3 ] = [p2.x,p2.y,p2.z]
      colors[ i*3...i*3+3 ] = [p2.r,p2.g,p2.b]

    material = new THREE.ParticleBasicMaterial( { size: @settings.size, vertexColors: true } );
    particleSystem = new THREE.ParticleSystem( geometry, material )
    @scene.add( particleSystem )

    angle = 0
    lastFrame = new Date().getTime()

    render = =>
      now = new Date().getTime()
      angle += @settings.cameraRotateSpeed * (now-lastFrame)
      radius = @settings.cameraDistance
      camera = new THREE.PerspectiveCamera(35, @settings.width / @settings.height, 0.1, 10000) # Far plane
      camera.position.set Math.sin(angle)*radius, 0, Math.cos(angle)*radius
      camera.lookAt @scene.position
      @renderer.render @scene, camera
      lastFrame = now
      requestAnimationFrame render
    
    render()


  @spherify: (p) ->
    r = 8
    d2r = Math.PI / 180
    {} =
      x: r*Math.sin(p.x * d2r) * Math.cos(p.y * d2r)
      y: r*Math.sin(p.y * d2r)
      z: r*Math.cos(p.x * d2r) * Math.cos(p.y * d2r)
      r: p.r
      g: p.g
      b: p.b


  @offsetHSL: (p,h,s,l) ->
    color = new THREE.Color()
    color.setRGB( p.r, p.g, p.b )
    color.offsetHSL(h,s,l)
    {} =
      x: p.x
      y: p.y
      z: p.z
      r: color.r
      g: color.g
      b: color.b

