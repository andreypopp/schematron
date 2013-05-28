schematron
==========

Yet another boilerplate-free schema validation library, Connect/Express middleware included

To get started, install ``schematron`` package via ``npm``::

    % npm install schematron

After that you will be able to use ``schematron`` library in your code.  The
basic usage example is as follows::

    var schematron = require('schematron'),
        validate = schematron.validate,
        optional = schematron.optional,
        either = schematron.either,
        any = schematron.any;


    var schema = {
      a: Number,
      b: optional(String),
      c: [either(String, Boolean)]
      d: {
        e: any,
        f: optional(Number)
      }
    };

    result = validate(schema, {a: 1});
    if (result.errors) {
      // handle errors
    } else {
      var data = result.data;
    }
