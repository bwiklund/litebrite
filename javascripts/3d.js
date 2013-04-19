(function() {
  var animate, camera, container, group, mouseX, mouseY, onDocumentMouseMove, onDocumentTouchMove, onDocumentTouchStart, onWindowResize, particle, render, renderer, scene, stats, windowHalfX, windowHalfY;

  window.onload = function() {
    var PI2, camera, container, group, i, particle, program, renderer, scene;
    container = document.createElement("div");
    document.body.appendChild(container);
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 3000);
    camera.position.z = 1000;
    scene = new THREE.Scene();
    PI2 = Math.PI * 2;
    program = function(context) {
      context.beginPath();
      context.arc(0, 0, 1, 0, PI2, true);
      context.closePath();
      return context.fill();
    };
    group = new THREE.Object3D();
    scene.add(group);
    i = 0;
    while (i < 1000) {
      particle = new THREE.Particle(new THREE.ParticleCanvasMaterial({
        color: Math.random() * 0x808008 + 0x808080,
        program: program
      }));
      particle.position.x = Math.random() * 2000 - 1000;
      particle.position.y = Math.random() * 2000 - 1000;
      particle.position.z = Math.random() * 2000 - 1000;
      particle.scale.x = particle.scale.y = Math.random() * 10 + 5;
      group.add(particle);
      i++;
    }
    renderer = new THREE.CanvasRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    container.appendChild(renderer.domElement);
    document.addEventListener("mousemove", onDocumentMouseMove, false);
    document.addEventListener("touchstart", onDocumentTouchStart, false);
    document.addEventListener("touchmove", onDocumentTouchMove, false);
    return window.addEventListener("resize", onWindowResize, false);
  };

  onWindowResize = function() {
    var windowHalfX, windowHalfY;
    windowHalfX = window.innerWidth / 2;
    windowHalfY = window.innerHeight / 2;
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    return renderer.setSize(window.innerWidth, window.innerHeight);
  };

  onDocumentMouseMove = function(event) {
    var mouseX, mouseY;
    mouseX = event.clientX - windowHalfX;
    return mouseY = event.clientY - windowHalfY;
  };

  onDocumentTouchStart = function(event) {
    var mouseX, mouseY;
    if (event.touches.length === 1) {
      event.preventDefault();
      mouseX = event.touches[0].pageX - windowHalfX;
      return mouseY = event.touches[0].pageY - windowHalfY;
    }
  };

  onDocumentTouchMove = function(event) {
    var mouseX, mouseY;
    if (event.touches.length === 1) {
      event.preventDefault();
      mouseX = event.touches[0].pageX - windowHalfX;
      return mouseY = event.touches[0].pageY - windowHalfY;
    }
  };

  animate = function() {
    requestAnimationFrame(animate);
    return render();
  };

  render = function() {
    camera.position.x += (mouseX - camera.position.x) * 0.05;
    camera.position.y += (-mouseY - camera.position.y) * 0.05;
    camera.lookAt(scene.position);
    group.rotation.x += 0.01;
    group.rotation.y += 0.02;
    return renderer.render(scene, camera);
  };

  container = void 0;

  stats = void 0;

  camera = void 0;

  scene = void 0;

  renderer = void 0;

  group = void 0;

  particle = void 0;

  mouseX = 0;

  mouseY = 0;

  windowHalfX = window.innerWidth / 2;

  windowHalfY = window.innerHeight / 2;

  $(function() {
    init();
    return animate();
  });

}).call(this);
