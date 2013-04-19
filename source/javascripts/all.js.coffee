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
  scene.fog = new THREE.Fog( 0x111111, 20, 45 );
  # geometry = new THREE.CubeGeometry(5, 5, 5)
  # material = new THREE.MeshLambertMaterial(color: 0xFF0000)
  # mesh = new THREE.Mesh(geometry, material)
  # scene.add mesh

  # light = new THREE.PointLight(0xFFFF00)
  # light.position.set 10, 0, 10
  # scene.add light

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
    color.offsetHSL(0,0.5,0)

    colors[ i ]     = color.r;
    colors[ i + 1 ] = color.g;
    colors[ i + 2 ] = color.b;


  material = new THREE.ParticleBasicMaterial( { size: 0.3, vertexColors: true } );

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


