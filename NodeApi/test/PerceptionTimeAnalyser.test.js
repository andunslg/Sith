/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 11/4/13
 * Time: 10:55 PM
 * To change this template use File | Settings | File Templates.
 */
perceptionAnalyser = require('../Analytics/PerceptionTimeAnalyser.js');

exports['calculate'] = function (test) {
    test.equal(perceptionAnalyser.calculate(2), 6);
    test.done();
};