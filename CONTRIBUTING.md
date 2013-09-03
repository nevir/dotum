Hacking on Dotum
=================

Hopefully, Dotum's development environment is relatively straightfoward, but
here's a walkthrough of its different facets.


General Workflow
----------------

After checking out Dotum and installing its bundle, you should simply run
`bundle exec guard` in a separate terminal window (or process).

The general philosophy is that [Guard](https://github.com/guard/guard) should be
managing the majority of the development workflow.  Any change you make should
run the appropriate tests.


Mutation-Driven Testing
-----------------------

Dotum strictly adheres to [mutation tests](tasks/spec/mutate.rake) for all core
classes (not rules) via [mutant](https://github.com/mbj/mutant).  This may be a
bit more stringent than you are used to, but it provides the following benefits:

* **Complete coverage.**  Mutant will mutate just about every facet of every
  function.

* **Confidence.**  If the specs pass mutation testing, you can be reasonably
  assured that a pull requests behaves as advertised.

* **Redundancy avoidance.**  Mutation tests tend to highlight redundant and
  useless code that can be safely removed.

* **Enforced granularity.**  You tend to write smaller and more focused tests.

Mutation tests do not run via `guard` (they take a while).  You should
periodically run them via `rake` or `rake spec:mutate`.  You can also emulate
the Travis environment via `rake spec:ci`.

Additionally, you can run mutation specs against specific objects and/or methods
by specifying them directly:

* `rake spec:mutate[Foo]` would run mutation specs for methods defined on
  `Dotum::Foo`.

* `rake spec:mutate[Foo#bar]` would run mutation specs for the instance method
  `bar` defined on `Dotum::Foo`.

* `rake spec:mutate[Fizz.buzz]` would run mutation specs for the module method
  `buzz` defined on `Dotum::Fizz`.


Test Organization
-----------------

Both to support mutant, and for better visibility, tests are organized
_per-method_.  For example:

* `Foo::Bar#baz` should have tests located at `spec/unit/foo/bar/baz_spec.rb`.

* `Fizz.buzz` should have tests located at
  `spec/unit/class_methods/buzz_spec.rb`.
