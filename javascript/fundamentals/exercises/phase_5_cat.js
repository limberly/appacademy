const Cat = function(name, owner) {
    this.name = name;
    this.owner = owner;

};

Cat.prototype.cuteStatement = function () {
    return console.log(`${this.owner} loves ${this.name}`);
}

Cat.prototype.meow = function () {
    console.log('meow');
}

const kitty = new Cat('paul', 'mom');
kitty.cuteStatement();

