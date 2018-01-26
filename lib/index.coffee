
_ = require 'lodash'
compileToPairs = (opt)->
  opt = _.defaults opt,
    array: true
    object: true
  return _toPairs = (obj, prefix = '')->

    if opt.array and _.isArray obj
      return _.flatMap obj, (value, index)->
        _toPairs value, prefix + "[#{index}]"
    if opt.object and _.isPlainObject obj
      prefix += '.' unless prefix is ''
      return _.flatMap obj, (value, index)->
        _toPairs value, prefix + index
    return [[prefix, obj]]

PATHARACHY =
  compileToPairs: compileToPairs
  toPairs: compileToPairs {}
  fromPairs: (pairs)->
    return _.reduce pairs, (result, pair)->
      _.set result, pair...
    , {}
  map: (obj, fn)->
    pairs =  PATHARACHY.toPairs obj
    return _.reduce pairs, (result, pair)->
      [patharchy, value] = pair
      _.set result, patharchy, fn value, patharchy, pairs
    , {}


module.exports = exports =  PATHARACHY
