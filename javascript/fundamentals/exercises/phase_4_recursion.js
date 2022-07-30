function range(start, end) {
    if (start === end) {
        return end;
    }
    let arr = [start];
    arr.push(range(start + 1, end));
    return arr.flat();
};


const sumRec = function(numbers) {
    if (numbers.length === 2) {
        return numbers[0] + numbers[1];
    }
    const last = numbers.pop();
    numbers[0] += last;
    return sumRec(numbers); 
};

function exponent1(base, exp) {
    if (exp === 0) {
        return 1;
    }

    return base * exponent1(base, exp - 1);
};

function exponent2(base, exp) {
    if (exp === 0) {
        return 1;
    } else if (exp === 1) {
        return base;
    } else if (exp % 2 === 1) {
        return base * exponent2(base, (exp - 1)/2) ** 2;
    } else if (exp % 2 === 0) {
        return exponent2(base, exp / 2) ** 2;
    }
}

function fibonacci(n) {
    if (n <= 0) {
        return 0;
    } else if (n === 1) {
        return 1;
    } else if (n === 2) {
        return [1, 1];
    }
    else {
        const before = fibonacci(n - 1).slice(-2);
        return [fibonacci(n - 1), before[0] + before[1]].flat();
    }
};

function deepDup(arr) {
    const arrLen = arr.length;
    const dup = [];
    for (let i = 0; i < arrLen; i++) {
        if (arr[i] instanceof Array) {
            dup.push(deepDup(arr[i]));
        } else if (typeof arr[i] === 'number') {
            dup.push(arr[i]);
        }
    }
    return dup;
};

function bsearch(arr, left, right, target) {
    const mid = Math.ceil((right + left) / 2);
    if (left > right) {
        return -1;
    }
    
    if (arr[mid] === target) {
        return mid;
    } else if (arr[mid] > target) {
        return bsearch(arr, left, mid - 1, target);
    } else {
        return bsearch(arr, mid + 1, right, target);
    }

};

function merge(left, right) {
    const merged = new Array();

    while (left.length > 0 && right.length > 0) {
        if (left[0] > right[0]) {
            merged.push(right.shift());
        } else {
            merged.push(left.shift());
        }
    }

    while (left.length > 0) {
        merged.push(left.shift());
    }

    while (right.length > 0) {
        merged.push(right.shift());
    }

    return merged;
};

function mergesort(arr) {
    if (arr.length === 1) {
        return arr;
    }

    const mid = Math.ceil(arr.length / 2);
    let left = arr.slice(0, mid);
    let right = arr.slice(mid);

    left = mergesort(left);
    right = mergesort(right);

    return merge(left, right);
};

function findsubsets(arr, pos) {
    pos = pos || 0;
    if (pos >= arr.length) {
        return [[]];
    } 

    let output = findsubsets(arr, pos + 1);

    for (let i = 1, endi = output.length ; i < endi; i++) {
        output.push(
            output.slice(i, i+1).concat(arr[pos])
        );
    }
    return output.concat(arr[pos]);
};

function subsets(arr) {
    return findsubsets(arr);
};



console.log(subsets([1,2,3]));
