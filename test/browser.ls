require 'es5-shim'
require 'es5-shim/es5-sham'

beanB = require 'doom-bean'
nwmatcherB = require 'doom-nwmatcher'

brofist = require 'brofist'
specs = require './specs'
reporter = (require 'brofist-browser') nwmatcherB, beanB

brofist.run specs, reporter
