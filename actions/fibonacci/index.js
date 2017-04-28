/**
 * This function computes a fibonacci mumber
 *
 * @param   n fibonacci sequence index
 * @return  the fibonacci number
 */
function fibo(n){
  if (n<0) return -1;
    else if (n==0) return 1;
      else if (n==1) return 1;
        else return fibo(n-1);
}

/**
 * Error codes
 */
var errors = {
  1:"index missing",
  2:"index sub zero"
};

/**
 * This action gets a fibonacci mumber
 *
 * @param   params.i fibonacci sequence index
 * @return  the fibonacci number
 */
function myAction(params) {

  return new Promise(function(resolve, reject) {
  
    if (! params.i){
      console.log(errors.1);
      reject(errors.1);
    }
    
    console.log('Calculating fibonacci number '+params.i);

    var n = fibo(params.i);

    if (n==-1) {
        console.log(errors.2);
        reject(errors.2);
    } else {
        console.log("result:"+n);
        resolve(n);
    };

  });
}

exports.main = myAction;
