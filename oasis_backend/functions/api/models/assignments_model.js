const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class AssignmentModel {
    constructor() {
        if (this.instance) return this.instance;
        AssignmentModel.instance = this;
    }

    get() {
        return database.getList("assignments");
    }

    getById(id) {
        return database.get("assignments", id);
    }

    create(assignment) {
        return database.create("assignments", assignment);
    }

    setId(assignment) {
        return database.setId("assignments", assignment.id, assignment);
    }

    delete(id) {
        return database.delete("assignments", id);
    }

    update(id, assignment) {
        return database.set("assignments", id, assignment);
    }
}

module.exports = new AssignmentModel();
