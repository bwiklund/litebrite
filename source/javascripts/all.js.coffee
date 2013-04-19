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

  # # now create the individual particles
  # for p in data
    
  #   r = 5
  #   d2r = Math.PI / 180
  #   # create a particle with random
  #   # position values, -250 -> 250
  #   pX = r*Math.sin(p.x * d2r)
  #   pY = r*Math.sin(p.y * d2r)
  #   pZ = r*Math.cos(p.x * d2r)
  #   particle = new THREE.Vector3(pX, pY, pZ)
  #   # add it to the geometry
  #   particles.vertices.push particle
  #   p++

  # # create the particle system
  # particleSystem = new THREE.ParticleSystem(particles, pMaterial)

  # console.log particleSystem
  # # add it to the scene
  # scene.add particleSystem



  nParticles = 1000
  
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

  color = new THREE.Color();

  n = 1000
  n2 = n / 2; #// particles spread in the cube

  for i in [0...positions.length] by 3

    # positions

    x = Math.random() * n - n2;
    y = Math.random() * n - n2;
    z = Math.random() * n - n2;

    positions[ i ]     = x;
    positions[ i + 1 ] = y;
    positions[ i + 2 ] = z;

    # colors

    vx = ( x / n ) + 0.5;
    vy = ( y / n ) + 0.5;
    vz = ( z / n ) + 0.5;

    color.setRGB( vx, vy, vz );

    colors[ i ]     = color.r;
    colors[ i + 1 ] = color.g;
    colors[ i + 2 ] = color.b;




  material = new THREE.ParticleBasicMaterial( { size: 15, vertexColors: true } );

  particleSystem = new THREE.ParticleSystem( geometry, material )

  scene.add( particleSystem )




  angle = 0

  setInterval ->
    angle += 0.01
    radius = 30
    camera = new THREE.PerspectiveCamera(35, 800 / 600, 0.1, 10000) # Far plane
    camera.position.set Math.sin(angle)*radius, 0, Math.cos(angle)*radius
    camera.lookAt scene.position
    renderer.render scene, camera
  , 1000/60







# geometry = new THREE.BufferGeometry()
# geometry.attributes =
#   position:
#     itemSize: 3
#     array: new Float32Array(particles * 3)
#     numItems: particles * 3

#   color:
#     itemSize: 3
#     array: new Float32Array(particles * 3)
#     numItems: particles * 3

# positions = geometry.attributes.position.array
# colors = geometry.attributes.color.array
# color = new THREE.Color()
# n = 1000 # particles spread in the cube
# n2 = n / 2
# i = 0

# while i < positions.length
  
#   # positions
#   x = Math.random() * n - n2
#   y = Math.random() * n - n2
#   z = Math.random() * n - n2
#   positions[i] = x
#   positions[i + 1] = y
#   positions[i + 2] = z
  
#   # colors
#   vx = (x / n) + 0.5
#   vy = (y / n) + 0.5
#   vz = (z / n) + 0.5
#   color.setRGB vx, vy, vz
#   colors[i] = color.r
#   colors[i + 1] = color.g
#   colors[i + 2] = color.b
#   i += 3
# geometry.computeBoundingSphere()

# #
# material = new THREE.ParticleBasicMaterial(
#   size: 15
#   vertexColors: true
# )
# particleSystem = new THREE.ParticleSystem(geometry, material)
# scene.add particleSystem
