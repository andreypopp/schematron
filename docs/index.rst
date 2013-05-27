schematron
==========

Yet another boilerplate-free schema validation library, Connect/Express middleware included

To get started, install ``schematron`` package via ``npm``::

    % npm install schematron

After that you will be able to use ``schematron`` library in your code.  The
basic usage example is as follows::

    var schematron = require('schematron');

    var schema = {
      a: Number,
      b: optional(String)
    };

    result = schematron.validate(schema, {a: 1});
    if (result.errors) {
      // handle errors
    } else {
      var data = result.data;
    }

