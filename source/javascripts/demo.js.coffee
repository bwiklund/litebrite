$ ->
  $.ajax
    type: 'get'
    url: 'data/points.json'
    success: (data) =>
      $("#canvas p").text("Creating point cloud")
      new LiteBrite 
        data: data
        transform: [
          LiteBrite.spherify
          (p) -> LiteBrite.offsetHSL(p,0,0.65,0)
        ]
        size: 0.15
        cameraDistance: 30
        fog: new THREE.Fog( 0x111111, 20, 43 );
      $("#canvas p").hide()