"use strict";

Array.prototype.myEach = function(callback) {
    // const result = []
    for (let i = 0; i < this.length; i++) {
        callback(this[i]);
        // result.push(callback(this[i]));
    }
    // return result;
};

Array.prototype.myMap = function(callback) {
    const newArr = [];
    this.myEach(function(el) {
        newArr.push(callback(el));
    });
    return newArr;
};

Array.prototype.myReduce = function(callback, initialValue) {
    let start = 0
    if (initialValue) {
        start = initialValue;
    }

    this.myEach(function(el) {
        start += callback(el);
    });
    return start;
};