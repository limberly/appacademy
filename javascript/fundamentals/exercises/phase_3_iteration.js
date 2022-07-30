"use strict";

Array.prototype.bubbleSort = function() {
    let that = this;
    const arrLen = this.length - 1;
    let notSorted = true;
    let count = 0;
    while (notSorted) {
        for (let i = 0; i < arrLen; i++) {
            if (that[i] > that[i+1]) {
                [that[i], that[i+1]] = [that[i+1], that[i]];
                count++;
            }
        }
        if (count === 0) {
            notSorted = false;
        }
        count = 0;
    }

    return that;
};

String.prototype.substrings = function(sub) {
    const strLen = this.length;
    const subLen = sub.length;
    const substrings = [];

    for (let i = 0; i < strLen; i++) {
        if (this.substring(i, i+subLen) === sub) {
            substrings.push(sub);
        }
    }
    return substrings;
};