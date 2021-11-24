const functions = require("firebase-functions");
const express = require("express");
const app = express();
const usersRouter = require("./api/controllers/users_controller");
const subjectsRouter = require("./api/controllers/subjects_controller");
const classroomsRouter = require("./api/controllers/classrooms_controller");
const teachersubjectclassroomsRouter = require("./api/controllers/teachersubjectclassrooms_controller");
const assignmentsRouter = require("./api/controllers/assignments_controller");
const submissionsRouter = require("./api/controllers/submissions_controller");

app.use(express.json());
app.use("/users", usersRouter);
app.use("/subjects", subjectsRouter);
app.use("/classrooms", classroomsRouter);
app.use("/teachersubjectclassrooms", teachersubjectclassroomsRouter);
app.use("/assignments", assignmentsRouter);
app.use("/submissions", submissionsRouter);

exports.api = functions.https.onRequest(app);

// To handle "Function Timeout" exception
exports.functionsTimeOut = functions.runWith({
    timeoutSeconds: 300,
});