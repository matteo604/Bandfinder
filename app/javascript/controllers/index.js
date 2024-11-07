// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Automatically load controllers from the importmap
eagerLoadControllersFrom("controllers", application);
