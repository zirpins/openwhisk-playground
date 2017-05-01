/*
 * fibonacci
 * https://github.com/zirpins/openwhisk-playground
 *
 * Copyright (c) 2017 Christian Zirpins
 * Licensed under the MIT license.
 */

'use strict';

/**
 * This function computes a fibonacci mumber
 *
 * @param   i fibonacci sequence index
 * @return  the fibonacci number or -1 if index is bad
 */
function fibo(i) {
    if (!i || i < 1)
        {return -1;}
    else if (i === 1)
        {return 1;}
    else if (i === 2)
        {return 1;}
    else
    {return fibo(i - 1) + fibo(i - 2);}
}

exports.get = fibo;