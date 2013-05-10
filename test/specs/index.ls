spec = (require 'brofist')!

chai = require 'chai'
chai.use (require 'chai-as-promised')
{expect} = chai

pinky = require 'pinky'
{sequentially, compose, pipeline, all, any} = require '../../lib'

ok   = -> void
fail = -> throw new Error 'failed'


module.exports = \
spec 'Pinky combinators' (it, spec) ->
  spec 'λ compose' ->
    it 'Should treat an empty list as fulfilled.' ->
      expect (compose []) .to.be.fulfilled

    it 'Should pipe values from right to left.' ->
      p = compose [(* 2), (+ 1), (-> 0)]
      expect p .to.become 2

    it 'Should fail as soon as one fails.' ->
      p = compose [ok, fail, ok]
      expect p .to.be.rejected.with /failed/

      
  spec 'λ pipeline' ->
    it 'Should treat an empty list as fulfilled.' ->
      expect (pipeline []) .to.be.fulfilled

    it 'Should pipe values from left to right.' ->
      p = pipeline [(-> 0), (- 1), (+ 2)]
      expect p .to.become 1

    it 'Should afil as soon as one fails.' ->
      p = pipeline [ok, fail, ok]
      expect p .to.be.rejected.with /failed/


  spec 'λ all' ->
    it 'Should treat an empty list as resolved.' ->
      expect (all []) .to.be.fulfilled

    it 'Should resolve to a list of all promise values.' ->
      p = all [(pinky \a), (pinky \b), (pinky \c)]
      expect p .to.become <[ a b c ]>

    it 'Should resolve to a list of all promise values (regular values).' ->
      p = all <[ a b c ]>
      expect p .to.become <[ a b c ]>

    it 'Should fail as soon as one fails.' ->
      x = pinky 'a'
      p = all [(x.then ok), (x.then fail), (x.then ok)]
      expect p .to.be.rejected.with /failed/

  spec 'λ any' ->
    it 'Should treat an empty list as fulfilled.' ->
      expect (any []) .to.be.fulfilled
