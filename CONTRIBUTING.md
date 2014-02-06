Hacking on Dotum
=================

After checking out Dotum and installing its bundle, you should simply run
`bundle exec guard` in a separate terminal window (or process).

The general philosophy is that [Guard](https://github.com/guard/guard) should be
managing the majority of the development workflow. Any time you touch a file,
it will run the appropriate tests, or reload the environment accordingly.
