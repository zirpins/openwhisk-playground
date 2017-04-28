/**
 * This function computes a fibonacci mumber
 *
 * @param   i fibonacci sequence index
 * @return  the fibonacci number
 */
function fibo(i) {
    if (i < 1) return -1;
    else if (i == 1) return 1;
    else if (i == 2) return 1;
    else return fibo(i - 1) + fibo(i - 2);
}

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

        console.log('Calculating fibonacci number ' + params.index);

        var n = fibo(params.index);

        if (n == -1) {
            console.log(errors.e2);
            reject(errors.e2);
        } else {
            console.log("resulting number:" + n);
            resolve({
                index: params.index,
                number: n
            });
        }

    });
}

exports.main = myAction;
