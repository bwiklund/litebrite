(function() {

  $(function() {
    var _this = this;
    return $.ajax({
      type: 'get',
      url: 'data/points.json',
      success: function(data) {
        return new LiteBrite({
          data: data,
          transform: [
            LiteBrite.spherify, function(p) {
              return LiteBrite.scale(p, 8);
            }, function(p) {
              return LiteBrite.offsetHSL(p, 0, 0.65, 0);
            }
          ],
          fog: new THREE.Fog(0x111111, 20, 43),
          element: $("#canvas")[0]
        });
      }
    });
  });

}).call(this);
