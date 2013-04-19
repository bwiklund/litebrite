# hello

$.ajax
  type: 'get'
  url: 'data/points.json'
  success: (data) ->
    createGeometry(data)
    #animate()
    #data = btoa(unescape(encodeURIComponent(data)));


createGeometry = (data) ->

  renderer = new THREE.WebGLRenderer()
  renderer.setSize 800, 600
  document.body.appendChild renderer.domElement
  scene = new THREE.Scene()

  # geometry = new THREE.CubeGeometry(5, 5, 5)
  # material = new THREE.MeshLambertMaterial(color: 0xFF0000)
  # mesh = new THREE.Mesh(geometry, material)
  # scene.add mesh

  light = new THREE.PointLight(0xFFFF00)
  light.position.set 10, 0, 10
  scene.add light




  # create the particle variables
  particleCount = 1800
  particles = new THREE.Geometry()
  pMaterial = new THREE.ParticleBasicMaterial(
    color: 0x000
    size: 0.1
  )

  # now create the individual particles
  for p in data
    
    r = 5
    d2r = Math.PI / 180
    # create a particle with random
    # position values, -250 -> 250
    pX = r*Math.sin(p.x * d2r)
    pY = r*Math.sin(p.y * d2r)
    pZ = r*Math.cos(p.x * d2r)
    particle = new THREE.Vector3(pX, pY, pZ)
    # add it to the geometry
    particles.vertices.push particle
    p++

  # create the particle system
  particleSystem = new THREE.ParticleSystem(particles, pMaterial)

  console.log particleSystem
  # add it to the scene
  scene.add particleSystem





  angle = 0

  setInterval ->
    angle += 0.01
    radius = 30
    camera = new THREE.PerspectiveCamera(35, 800 / 600, 0.1, 10000) # Far plane
    camera.position.set Math.sin(angle)*radius, 0, Math.cos(angle)*radius
    camera.lookAt scene.position
    renderer.render scene, camera
  , 1000/60
