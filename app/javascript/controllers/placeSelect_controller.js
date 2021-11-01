// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "value" ]

  get value(){
    return this.valueTarget.value
}
  placeLoad() {
    window.location = this.value
  }
}
