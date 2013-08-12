/**
 * Created with IntelliJ IDEA.
 * User: prabhath
 * Date: 8/11/13
 * Time: 10:09 PM
 * To change this template use File | Settings | File Templates.
 */


exports.parseDateTime= function (date,time) {
    var parts = date.split('/');
    var parts2=  time.split(':');
    // new Date(year, month [, date [, hours[, minutes[, seconds[, ms]]]]])
    return new Date(parts[2], parts[1]-1, parts[0],parts2[0],parts2[1]); // months are 0-based
}