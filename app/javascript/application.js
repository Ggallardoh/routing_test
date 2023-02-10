// Entry point for the build script in your package.json
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "./controllers"
import * as bootstrap from "bootstrap"
//= require underscore
//= require gmaps/google
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap-dropdown
//= require bootstrap
//= require bootstrap-sprockets
//= require turbolinks
//= require popper
//= require_tree.