# frozen_string_literal: true

# tests for the error
require_relative 'tsv_buddy'
require_relative 'yaml_buddy'

class Tester
  include TsvBuddy
  include YamlBuddy
end

tests = Tester.new
tests.take_yaml(File.read('data/survey.yml'))
s = tests.to_tsv
puts s[-1]
t = File.read('data/survey.tsv')
puts t[-1]
