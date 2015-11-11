specContext = require.context '.', true, /Spec\.coffee$/
srcContext = require.context '../../main/js/components', true, /\.js$/

[specContext, srcContext].forEach (ctx) ->
  ctx.keys().forEach ctx