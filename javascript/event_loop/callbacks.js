'use strict';

class Clock {
    constructor () {
        this.time = new Date();
        this.printTime(this.time);
        setInterval(this._tick, 1000, this.time);
    }

    printTime (t) {
        console.log(t.toLocaleTimeString());
    }

    _tick (t) {
        t.setTime(t.getTime() + 1000);
        Clock.prototype.printTime(t);
    }

}

new Clock();