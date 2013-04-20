![Sample](https://raw.github.com/bwiklund/litebrite/master/source/images/globes.png)

litebrite
===

A pointcloud rendering toy. Built in coffeescript, with threejs, webgl, and a sprinkle of jquery.

As it's using buffered geometry, and can handle quite a few particles at once.

Usage example, from the globe demo:
===

The raw data:
```
[
  {
    r: 0.440924
    g: 0.273974
    b: 0.195477
    x: 17.470493
    y: 47.867077
  },
  ...
]
```

Setup:
```
new LiteBrite
  data: data
  transform: [
    LiteBrite.spherify
    (p) -> LiteBrite.scale(p,8)
    (p) -> LiteBrite.offsetHSL(p,0,0.65,0)
  ]
  fog: new THREE.Fog( 0x111111, 20, 43 )
```

Note that we're chaining two 'transforms' together:

- LiteBrite.spherify: converts our latitude and logitude to 3d coordinates on a globe
- LiteBrite.saturate: adjusts the HSV of the dots

You can write you own transforms easily. Each point is passed through each transform, and a new point is returned. 

The format of their input and output is totally up to you, as long as they don't break each other, and the final output is in the right format (see next example)

Here's a transform that does nothing at all:
```
fooTransform = (p) ->
  return
    x: p.x
    y: p.y
    z: p.z
    r: p.r
    g: p.g
    b: p.b
```

If your data is already in the format you want, you can skip transforms alltogether:

```
new LiteBrite data: data
```

To do:
- Parameterize more stuff
-- Camera position and motion
-- Particle size
- Updating data
- Camera controls

Have fun, contributions very welcome.

Check out the [source and demo](https://github.com/bwiklund/litebrite/tree/master/source/javascripts) for other options

[See it in action](http://bwiklund.github.com/litebrite)
