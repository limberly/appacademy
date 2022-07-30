"use strict";

Array.prototype.uniq = function() {
    let uniqArr = [];
    this.forEach(function(el) {
        if (!uniqArr.includes(el)) {
            uniqArr.push(el);
        }
    });
    return uniqArr;
};

Array.prototype.twoSum = function() {
    let zero = [];
    const arrLen = this.length;
    for (let i = 0; i < arrLen; i++) {
        for (let j = i+ 1; j < arrLen; j++) {
            if (this[i] + this[j] === 0) {
                zero.push([i, j]);
            }
        }
    }
    return zero;
};

Array.prototype.transpose = function() {
    const transposed = new Array(this[0].length);
    for (let j = 0; j < transposed.length; j++) {
        for (let i = 0; i < this.length; i++) {
            if (i === 0) {
                transposed[j] = [];
            }
            transposed[j][i] = this[i][j];
        }
    }
    return transposed;
}
