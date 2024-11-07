// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import NavbarController from "./navbar_controller";
import ChatController from "./chat_controller";

// Automatically load controllers from the importmap
eagerLoadControllersFrom("controllers", application);

// manually register specific controllers
application.register("navbar", NavbarController);
application.register("chat", ChatController);
