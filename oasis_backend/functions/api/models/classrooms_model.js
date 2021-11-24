const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class ClassroomModel {
    constructor() {
        if (this.instance) return this.instance;
        ClassroomModel.instance = this;
    }

    get() {
        return database.getList("classrooms");
    }

    getById(id) {
        return database.get("classrooms", id);
    }

    create(classroom) {
        return database.create("classrooms", classroom);
    }

    setId(classroom) {
        return database.setId("classrooms", classroom.id, classroom);
    }

    delete(id) {
        return database.delete("classrooms", id);
    }

    update(id, classroom) {
        return database.set("classrooms", id, classroom);
    }
}

module.exports = new ClassroomModel();
