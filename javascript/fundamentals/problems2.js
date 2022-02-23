function titleize(arr, callback) {
    const title = function(name) {
        return 'Mx. ' + name + ' Jingleheimer Schmidt'
    }
    const newArr = arr.map(title)
    return newArr.forEach(callback)
}

// titleize(['John', 'Lim'], console.log)

function Elephant(name, height, tricks) {
    this.name = name;
    this.height = height;
    this.tricks = tricks;

}

let ele = new Elephant('bro', 155, ['saying hello', 'waving nose']);

Elephant.prototype.trumpet = function() {
    console.log(this.name + " the elephant goes 'phrRRRRRRR'!!!!");
};

Elephant.prototype.grow = function() {
    this.height += 12;
    console.log(this.height)
};

Elephant.prototype.addTrick = function(trick) {
    this.tricks.push(trick);
    console.log(this.tricks);
};

Elephant.prototype.play = function() {
    numTricks = this.tricks.length - 1;
    selectTrick = Math.floor(Math.random() * numTricks);
    console.log(this.name + ' is ' + this.tricks[selectTrick]);
};

// ele.trumpet();
// ele.grow();
// ele.addTrick('eat pussy');
// ele.play();

let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

let herd = [ellie, charlie, kate, micah];

Elephant.paradeHelper = function(elephant) {
    console.log(elephant.name +' is trotting by!');
}

// herd.forEach(Elephant.paradeHelper);

function dinnerBreakfast() {
    let order = "I'd like cheesy scrambled eggs";

    function addOrder(food) {
        food ? order += " and " + food : order;
        console.log(order + ' please');
        return order;    
    }
    
    return (newFood) => addOrder(newFood);
}

let bfastOrder = dinnerBreakfast();
bfastOrder('strawberry');
bfastOrder('clam chowder');