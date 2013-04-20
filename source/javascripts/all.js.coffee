# hello


class LiteBrite

  constructor: (@settings) ->
    @addPoints()

  initThreeJS: ->
    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize 500, 500
    $("#canvas")[0].appendChild @renderer.domElement
    @scene = new THREE.Scene()
    @scene.fog = new THREE.Fog( 0x111111, 20, 45 );
  

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

    color = new THREE.Color()
    for p,j in @settings.data
      i = j*3

      p2 = @settings.transform p

      color.setRGB( p2.r, p2.g, p2.b )
      color.offsetHSL(0,0.65,0)

      positions[ i...i+3 ] = [p2.x,p2.y,p2.z]
      colors[ i...i+3 ] = [color.r,color.g,color.b]

    material = new THREE.ParticleBasicMaterial( { size: 0.3, vertexColors: true } );
    particleSystem = new THREE.ParticleSystem( geometry, material )
    @scene.add( particleSystem )

    angle = 0
    lastFrame = new Date().getTime()

    render = =>
      now = new Date().getTime()
      angle += 0.0003 * (now-lastFrame)
      radius = 30
      camera = new THREE.PerspectiveCamera(35, 500 / 500, 0.1, 10000) # Far plane
      camera.position.set Math.sin(angle)*radius, 0, Math.cos(angle)*radius
      camera.lookAt @scene.position
      @renderer.render @scene, camera
      lastFrame = now
      requestAnimationFrame render
    
    render()


  @globeTransform: (p) ->
    r = 8
    d2r = Math.PI / 180
    {} =
      x: r*Math.sin(p.x * d2r) * Math.cos(p.y * d2r)
      y: r*Math.sin(p.y * d2r)
      z: r*Math.cos(p.x * d2r) * Math.cos(p.y * d2r)
      r: p.r
      g: p.g
      b: p.b



$ ->
  $.ajax
    type: 'get'
    url: 'data/points.json'
    success: (data) =>
      $("#canvas p").text("Creating point cloud")
      new LiteBrite data: data, transform: LiteBrite.globeTransform
      $("#canvas p").hide()

