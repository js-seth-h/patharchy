patharachy = require '../lib'
chai = require 'chai'
expect = chai.expect
debug = require('debug')('test')

feature = describe
scenario = it

describe 'toPairs', ()->
  it 'given Object, then return all leaf list', (done)->
    list = patharachy.toPairs
      n1:
        n11: 'test'
      n2:
        n21: '21'
        n22: '22'
      n3: 'root'
    debug 'list=', list
    expect(list).eql [
      ['n1.n11', 'test' ]
      ['n2.n21', '21' ]
      ['n2.n22', '22' ]
      ['n3', 'root' ]
    ]
    done()

  it 'given array in, then return all leaf list', (done)->
    list = patharachy.toPairs
      n1: [1,2,3]
      n2: [
        v: 1
      ,
        v: 2
        w: 3
      ]
      n3: 'root'
    debug 'list=', list
    expect(list).eql [
      ['n1[0]', 1 ]
      ['n1[1]', 2 ]
      ['n1[2]', 3 ]
      ['n2[0].v', 1 ]
      ['n2[1].v', 2 ]
      ['n2[1].w', 3 ]
      ['n3', 'root' ]
    ]
    done()

  it 'given array in, then return all leaf list', (done)->
    toPairs = patharachy.compileToPairs array: false
    list = toPairs
      n1: [1,2,3]
      n2: [
        v: 1
      ,
        v: 2
        w: 3
      ]
      n3: 'root'
    debug 'list=', list
    expect(list).eql [
      ['n1', [1,2,3] ]
      ['n2', [{v:1},{v:2, w:3} ] ]
      ['n3', 'root' ]
    ]
    done()

  it 'given array in, then return all leaf list', (done)->
    toPairs = patharachy.compileToPairs object: false
    list = toPairs [
      v: 1
    ,
      v: 2
      w: 3
    ,
      'test'
    ]
    debug 'list=', list
    expect(list).eql [
      ['[0]', {v : 1} ]
      ['[1]', {v:2, w:3} ]
      ['[2]', 'test']
    ]
    done()


describe 'fromPairs', ()->
  it 'given sample', ()->
    obj = patharachy.fromPairs [
      ['n1.n11', 'test' ]
      ['n2.n21', '21' ]
      ['n2.n22', '22' ]
      ['n3', 'root' ]
    ]

    expect(obj).eql
      n1:
        n11: 'test'
      n2:
        n21: '21'
        n22: '22'
      n3: 'root'

  it 'given sample 2', ()->

    obj = patharachy.fromPairs [
      ['n1[0]', 1 ]
      ['n1[1]', 2 ]
      ['n1[2]', 3 ]
      ['n2[0].v', 1 ]
      ['n2[1].v', 2 ]
      ['n2[1].w', 3 ]
      ['n3', 'root' ]
    ]

    expect(obj).eql
      n1: [1,2,3]
      n2: [
        v: 1
      ,
        v: 2
        w: 3
      ]
      n3: 'root'


  it 'given sample 3', ()->
    obj = patharachy.fromPairs [
      ['n1', [1,2,3] ]
      ['n2', [{v:1},{v:2, w:3} ] ]
      ['n3', 'root' ]
    ]

    expect(obj).eql
      n1: [1,2,3]
      n2: [
        v: 1
      ,
        v: 2
        w: 3
      ]
      n3: 'root'

  it 'given sample 4', ()->
    obj = patharachy.fromPairs [
      ['[0]', {v : 1} ]
      ['[1]', {v:2, w:3} ]
      ['[2]', 'test']
    ]
    debug obj
    expect(obj).eql
      '0':
        v: 1
      '1':
        v: 2
        w: 3
      '2':
        'test'
