# hello

class LiteBrite
  constructor: (arg) ->
    if arg.constructor == Array
      @addPoints(arg)


  initThreeJS: ->
    @renderer = new THREE.WebGLRenderer()
    @renderer.setSize 500, 500
    $("#canvas")[0].appendChild @renderer.domElement
    @scene = new THREE.Scene()
    @scene.fog = new THREE.Fog( 0x111111, 20, 45 );
  

  addPoints: (data) =>

    @initThreeJS()

    nParticles = data.length

    geometry = new THREE.BufferGeometry()
    geometry.attributes =
      position:
        itemSize: 3
        array: new Float32Array(nParticles * 3)
        numItems: nParticles * 3

      color:
        itemSize: 3
        array: new Float32Array(nParticles * 3)
        numItems: nParticles * 3

    positions = geometry.attributes.position.array
    colors = geometry.attributes.color.array

    color = new THREE.Color()

    r = 8
    d2r = Math.PI / 180

    for p,j in data
      i = j*3

      positions[ i ]     = r*Math.sin(p.x * d2r) * Math.cos(p.y * d2r)
      positions[ i + 1 ] = r*Math.sin(p.y * d2r)
      positions[ i + 2 ] = r*Math.cos(p.x * d2r) * Math.cos(p.y * d2r)

      color.setRGB( p.r, p.g, p.b )
      color.offsetHSL(0,0.65,0)

      colors[ i ]     = color.r;
      colors[ i + 1 ] = color.g;
      colors[ i + 2 ] = color.b;

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


$ ->
  $.ajax
    type: 'get'
    url: 'data/points.json'
    success: (data) =>
      $("#canvas p").text("Creating point cloud")
      new LiteBrite(data)
      $("#canvas p").hide()

