{ok, equal, deepEqual, notDeepEqual} = require 'assert'
{validate, any, either, optional} = require './src/index'


describe 'schema validation', ->

  assertValid = ({schema, data}) ->
    v = validate(schema, data)
    deepEqual v.errors, undefined
    deepEqual v.data, data

  assertInvalid = ({schema, data, errors}) ->
    v = validate(schema, data)
    deepEqual v.errors, errors

  it 'validates number', ->
    assertValid schema: Number, data: 1
    assertInvalid schema: Number, data: '1', errors: "should be a number"

  it 'validates string', ->
    assertValid schema: String, data: '1'
    assertInvalid schema: String, data: 1, errors: "should be a string"

  it 'validates boolean', ->
    assertValid schema: Boolean, data: true
    assertInvalid schema: Boolean, data: 'true', errors: "should be a boolean"

  describe 'array validation', ->

    it 'validates array', ->
      assertValid schema: [Number], data: [1, 2]
      assertInvalid schema: [Number], data: ['true'], errors: {"0": "should be a number"}
      assertInvalid schema: [Number], data: [1, 'true'], errors: {"1": "should be a number"}

    it 'validates empty array', ->
      assertValid schema: [Number], data: []
      assertValid schema: [String], data: []

  describe 'object validation', ->

    it 'validates object', ->
      schema = {k: Number}
      assertValid schema: schema, data: {k: 1}
      assertInvalid schema: schema, data: {k: true}, errors: {"k": "should be a number"}

    it 'validates object with optional keys', ->
      schema = {k: Number, ko: optional(Number)}
      assertValid schema: schema, data: {k: 1, ko: undefined}
      assertValid schema: schema, data: {k: 1, ko: 2}
      assertInvalid schema: schema, data: {k: 1, ko: '2'}, errors: {"ko": "should be a number"}

  it 'validates either', ->
    schema = either(Number, String)
    assertValid schema: schema, data: 1
    assertValid schema: schema, data: '1'
    assertInvalid schema: schema, data: true, errors: ["should be a number", "should be a string"]

  it 'validates any', ->
    schema = any
    assertValid schema: schema, data: 1
    assertValid schema: schema, data: '1'
    assertValid schema: schema, data: true
    assertValid schema: schema, data: []
    assertValid schema: schema, data: {}
