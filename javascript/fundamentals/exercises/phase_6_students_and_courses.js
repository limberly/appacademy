const Student = function(firstName, lastName, courses) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.courses = courses || [];

};

Student.prototype.name = function () {
    return console.log(`${this.firstName} ${this.lastName}`);
};

Student.prototype.hasConflict = function(course) {
    this.courses.forEach(function(e) {
        if (e.conflictsWith(course)) {
            return true;
        }
    });
    return false;
}

Student.prototype.enroll = function (course) {
    if (this.courses.includes(course)) {
        return console.log('already enrolled');
    } else if (this.hasConflict(course)) {
        return console.log('course conflict');
    } else {
        this.courses.push(course);
        course.students.push(this);
        return console.log(`enrolled in ${course.name}`);
    }
};

Student.prototype.courseLoad = function () {
    const courses = {};
    this.courses.forEach(function(e) {
        if (courses[e.department]) {
            courses[e.department] += e.credits;
        } else {
            courses[e.department] = e.credits;
        }
    });
    return courses;
};

const Course = function(name, department, credits, days, time) {
    this.name = name;
    this.department = department;
    this.credits = credits || 3;
    this.days = days || ['mon', 'wed', 'fri'];
    this.time = time || '11am'
    this.students = [];
};

Course.prototype.addStudent = function(student) {
    this.students.push(student.name());
    return student.name();
};

Course.prototype.conflictsWith = function(course) {
    const that = this;
    course.days.forEach(function(e) {
        if (that.days.includes(e) && (that.time === course.time)) {
            return true;
        } else {
            return false;
        }
    });
};



const lim = new Student('hyungue', 'lim');
lim.name();

const math = new Course('calculus', 'math', 3);
const math2 = new Course('calculus2', 'math', 3);
const chem = new Course('chemistry', 'chemistry', 3);

lim.enroll(math);
lim.enroll(math2);
lim.enroll(chem);
console.log(lim.courseLoad());
