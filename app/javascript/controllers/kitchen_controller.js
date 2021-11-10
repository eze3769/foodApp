import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  get output(){
    return this.outputTarget
}
  connect() {
    
    let time =  this.output.getAttribute("ref")
    let parsedTime = new Date(time)
    
    
    // hours_since_creation = (Time.zone.now - @record.created_at)
    
    setInterval(()=>{
        let actualTime = new Date
        let delay =  (new Date(actualTime - parsedTime))/1000
        let hours = Math.floor(delay/3600)
        let minutes =  Math.floor((delay - hours*3600)/60)
        let seconds = Math.round(delay - hours*3600 - minutes*60)
        this.output.textContent = `${hours}:${minutes}:${seconds}`
    },1000)
  }
}



