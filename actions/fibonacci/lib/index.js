/**
 * Created by zirpins on 01.05.17.
 */

var fibonacci = require('./fibonacci');
var Promise = require('promise');

/**
 * Error codes
 */
var errors = {
    e1: "index missing",
    e2: "index too small"
};

/**
 * This action gets a fibonacci mumber
 *
 * @param   params.i fibonacci sequence index
 * @return  the fibonacci number
 */
function myAction(params) {

    return new Promise(function (resolve, reject) {

        if (!params.index) {
            console.log(errors.e1);
            reject({
                headers: {
                    'Content-Type': 'application/json'
                },
                statusCode: 502,
                body: {
                    'error': errors.e1
                }
            });
        }

        var i = parseInt(params.index, 10);

        console.log('Calculating fibonacci number ' + i);

        var n = fibonacci.get(i);

        if (n === -1) {
            console.log(errors.e2);
            reject({
                headers: {
                    'Content-Type': 'application/json'
                },
                statusCode: 502,
                body: {
                    'error': errors.e2
                }
            });
        } else {
            console.log("resulting number:" + n);
            resolve(
                {
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    statusCode: 200,
                    body: {
                        'index': i,
                        'number': n
                    }
                });
        }

    });
}

exports.main = myAction;