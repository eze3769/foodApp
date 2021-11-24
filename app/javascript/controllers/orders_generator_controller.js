import ApplicationController from './application_controller'

/* This is the custom StimulusReflex controller for the OrdersGenerator Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {


  static targets = [ "input" ]

    get value(){
      return this.inputTarget.value
  }

  add () {
  

    this.stimulate("orders_generator#add")
  }
 
}
