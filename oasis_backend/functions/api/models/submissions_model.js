const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class SubmissionModel {
    constructor() {
        if (this.instance) return this.instance;
        SubmissionModel.instance = this;
    }

    get() {
        return database.getList("submissions");
    }

    getById(id) {
        return database.get("submissions", id);
    }

    create(submission) {
        return database.create("submissions", submission);
    }

    setId(submission) {
        return database.setId("submissions", submission.id, submission);
    }

    delete(id) {
        return database.delete("submissions", id);
    }

    update(id, submission) {
        return database.set("submissions", id, submission);
    }
}

module.exports = new SubmissionModel();
