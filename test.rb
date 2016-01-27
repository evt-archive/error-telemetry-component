require_relative './test/test_init'

TestBench::Runner.('test/spec.rb') or exit 1
