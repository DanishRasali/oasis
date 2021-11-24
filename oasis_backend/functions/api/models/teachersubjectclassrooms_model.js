const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class TeacherSubjectClassroomModel {
    constructor() {
        if (this.instance) return this.instance;
        TeacherSubjectClassroomModel.instance = this;
    }

    get() {
        return database.getList("teachersubjectclassrooms");
    }

    getById(id) {
        return database.get("teachersubjectclassrooms", id);
    }

    create(teachersubjectclassroom) {
        return database.create("teachersubjectclassrooms", teachersubjectclassroom);
    }

    setId(teachersubjectclassroom) {
        return database.setId("teachersubjectclassrooms", teachersubjectclassroom.id, teachersubjectclassroom);
    }

    delete(id) {
        return database.delete("teachersubjectclassrooms", id);
    }

    update(id, teachersubjectclassroom) {
        return database.set("teachersubjectclassrooms", id, teachersubjectclassroom);
    }
}

module.exports = new TeacherSubjectClassroomModel();
