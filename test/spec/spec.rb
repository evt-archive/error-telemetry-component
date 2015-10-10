require_relative 'test_init'

Runner.!('spec/*.rb') { |exclude| exclude == 'spec_init.rb' }
