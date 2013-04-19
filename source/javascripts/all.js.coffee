# hello
#= require ./3d

$.ajax
  type: 'get'
  url: 'data/points.json'
  success: (data) ->
    console.log data[0..10]
    #data = btoa(unescape(encodeURIComponent(data)));
