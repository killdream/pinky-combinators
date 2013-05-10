require 'es5-shim'
require 'es5-shim/es5-sham'

brofist = require 'brofist'
specs   = [require './specs']
tap     = require 'brofist-tap'

brofist.run specs, tap!
