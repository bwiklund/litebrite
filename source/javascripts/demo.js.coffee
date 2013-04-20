$ ->
  $.ajax
    type: 'get'
    url: 'data/points.json'
    success: (data) =>

      new LiteBrite
        data: data
        transform: [
          LiteBrite.spherify
          (p) -> LiteBrite.scale(p,8)
          (p) -> LiteBrite.offsetHSL(p,0,0.65,0)
        ]
        fog: new THREE.Fog( 0x111111, 20, 43 )
        element: $("#canvas")[0]