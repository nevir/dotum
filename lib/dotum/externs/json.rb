# encoding: utf-8

begin
  require "json"
rescue LoadError
  # Fall back to the embedded pure-Ruby JSON implementation.
  $LOAD_PATH.unshift(Dotum::EXTERN_PATH.join("json", "lib").to_s)
  require "json"
end
