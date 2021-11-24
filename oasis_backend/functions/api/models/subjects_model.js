const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class SubjectModel {
    constructor() {
        if (this.instance) return this.instance;
        SubjectModel.instance = this;
    }

    get() {
        return database.getList("subjects");
    }

    getById(id) {
        return database.get("subjects", id);
    }

    create(subject) {
        return database.create("subjects", subject);
    }

    setId(subject) {
        return database.setId("subjects", subject.id, subject);
    }

    delete(id) {
        return database.delete("subjects", id);
    }

    update(id, subject) {
        return database.set("subjects", id, subject);
    }
}

module.exports = new SubjectModel();
