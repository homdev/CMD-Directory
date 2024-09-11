// app/javascript/controllers/index.js

import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

eagerLoadControllersFrom("controllers", application);

import EvaluationController from "./evaluation_controller";
import ProjectController from "./project_controller";

application.register("evaluation", EvaluationController);
application.register("project", ProjectController);
