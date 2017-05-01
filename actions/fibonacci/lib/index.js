/**
 * Created by zirpins on 01.05.17.
 */

var fibonacci = require('./fibonacci');

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
            reject(errors.e1);
        }

        var i = parseInt(params.index);

        console.log('Calculating fibonacci number ' + i);

        var n = fibonacci.get(i);

        if (n == -1) {
            console.log(errors.e2);
            reject(errors.e2);
        } else {
            console.log("resulting number:" + n);
            resolve({
                'index' : i,
                'number' : n,
                'provider' : params.PROVIDER_NAME
            });
        }

    });
}

exports.main = myAction;