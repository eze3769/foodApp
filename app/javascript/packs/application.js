// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import './index.js'
import "channels"
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"



Rails.start()
Turbolinks.start()
ActiveStorage.start()
window.Rails = require("@rails/ujs")
window.Stimulus = Application.start()
window.bootstrap = require('bootstrap/dist/js/bootstrap.bundle.js')
import '../bootstrap/bootstrap_js_files.js'
const context = require.context("../controllers", true, /\.js$/)
Stimulus.load(definitionsFromContext(context))

import "controllers"

