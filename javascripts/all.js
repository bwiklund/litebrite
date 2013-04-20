(function() {
  var LiteBrite,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  LiteBrite = (function() {

    function LiteBrite(settings) {
      this.settings = settings;
      this.addPoints = __bind(this.addPoints, this);

      this.addPoints();
    }

    LiteBrite.prototype.initThreeJS = function() {
      this.renderer = new THREE.WebGLRenderer({
        antialias: true
      });
      this.renderer.setSize(500, 500);
      $("#canvas")[0].appendChild(this.renderer.domElement);
      this.scene = new THREE.Scene();
      return this.scene.fog = new THREE.Fog(0x111111, 20, 43);
    };

    LiteBrite.prototype.generateVertexBuffer = function(len) {
      var geometry;
      geometry = new THREE.BufferGeometry();
      geometry.attributes = {
        position: {
          itemSize: 3,
          array: new Float32Array(len * 3),
          numItems: len * 3
        },
        color: {
          itemSize: 3,
          array: new Float32Array(len * 3),
          numItems: len * 3
        }
      };
      return geometry;
    };

    LiteBrite.prototype.addPoints = function() {
      var angle, colors, geometry, i, lastFrame, material, p, p2, particleSystem, positions, render, transform, _i, _j, _len, _len1, _ref, _ref1, _ref2, _ref3, _ref4, _ref5,
        _this = this;
      this.initThreeJS();
      geometry = this.generateVertexBuffer(this.settings.data.length);
      positions = geometry.attributes.position.array;
      colors = geometry.attributes.color.array;
      _ref = this.settings.data;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        p = _ref[i];
        p2 = p;
        _ref1 = this.settings.transform;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          transform = _ref1[_j];
          p2 = transform(p2);
        }
        [].splice.apply(positions, [(_ref2 = i * 3), (i * 3 + 3) - _ref2].concat(_ref3 = [p2.x, p2.y, p2.z])), _ref3;
        [].splice.apply(colors, [(_ref4 = i * 3), (i * 3 + 3) - _ref4].concat(_ref5 = [p2.r, p2.g, p2.b])), _ref5;
      }
      material = new THREE.ParticleBasicMaterial({
        size: 0.15,
        vertexColors: true
      });
      particleSystem = new THREE.ParticleSystem(geometry, material);
      this.scene.add(particleSystem);
      angle = 0;
      lastFrame = new Date().getTime();
      render = function() {
        var camera, now, radius;
        now = new Date().getTime();
        angle += 0.0003 * (now - lastFrame);
        radius = 30;
        camera = new THREE.PerspectiveCamera(35, 500 / 500, 0.1, 10000);
        camera.position.set(Math.sin(angle) * radius, 0, Math.cos(angle) * radius);
        camera.lookAt(_this.scene.position);
        _this.renderer.render(_this.scene, camera);
        lastFrame = now;
        return requestAnimationFrame(render);
      };
      return render();
    };

    LiteBrite.spherify = function(p) {
      var d2r, r;
      r = 8;
      d2r = Math.PI / 180;
      return {
        x: r * Math.sin(p.x * d2r) * Math.cos(p.y * d2r),
        y: r * Math.sin(p.y * d2r),
        z: r * Math.cos(p.x * d2r) * Math.cos(p.y * d2r),
        r: p.r,
        g: p.g,
        b: p.b
      };
    };

    LiteBrite.saturate = function(p) {
      var color;
      color = new THREE.Color();
      color.setRGB(p.r, p.g, p.b);
      color.offsetHSL(0, 0.65, 0);
      return {
        x: p.x,
        y: p.y,
        z: p.z,
        r: color.r,
        g: color.g,
        b: color.b
      };
    };

    return LiteBrite;

  })();

  $(function() {
    var _this = this;
    return $.ajax({
      type: 'get',
      url: 'data/points.json',
      success: function(data) {
        $("#canvas p").text("Creating point cloud");
        new LiteBrite({
          data: data,
          transform: [LiteBrite.spherify, LiteBrite.saturate]
        });
        return $("#canvas p").hide();
      }
    });
  });

}).call(this);
