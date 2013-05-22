{ok, equal, deepEqual, notDeepEqual} = require 'assert'
{validate, any, either, optional} = require './src/index'

describe 'schema validation', ->

  it 'validates number', ->
    deepEqual validate(Number, 1).errors, undefined
    deepEqual validate(Number, '1').errors, "should be a number"

  it 'validates string', ->
    deepEqual validate(String, '1').errors, undefined
    deepEqual validate(String, 1).errors, "should be a string"

  it 'validates boolean', ->
    deepEqual validate(Boolean, true).errors, undefined
    deepEqual validate(Boolean, 'true').errors, "should be a bool"

  describe 'array validation', ->

    it 'validates array', ->
      deepEqual validate([Number], [1, 2]).errors, undefined
      deepEqual validate([Number], [1, 'true']).errors, {"1": "should be a number"}

    it 'validates empty array', ->
      deepEqual validate([Number], []).errors, undefined
      deepEqual validate([String], []).errors, undefined

  describe 'object validation', ->

    it 'validates object', ->
      deepEqual validate({k: Number}, {k: 1}).errors, undefined
      deepEqual validate({k: Number}, {k: 'true'}).errors, {"k": "should be a number"}

    it 'validates object with optional keys', ->
      schema = {k: Number, ko: optional(Number)}
      deepEqual validate(schema, {k: 1}).errors, undefined
      deepEqual validate(schema, {k: 1, ko: 2}).errors, undefined
      deepEqual validate(schema, {k: 1, ko: '2'}).errors, {"ko": "should be a number"}

  it 'validates either', ->
    deepEqual validate(either(Number, String), 1).errors, undefined
    deepEqual validate(either(Number, String), '1').errors, undefined
    notDeepEqual validate(either(Number, String), true).errors, undefined

  it 'validates any', ->
    schema = any
    deepEqual validate(any, 1).errors, undefined
    deepEqual validate(any, '1').errors, undefined
    deepEqual validate(any, true).errors, undefined
    deepEqual validate(any, []).errors, undefined
    deepEqual validate(any, {}).errors, undefined
