import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs";


export default class extends Controller {
    static targets = [ "url" ]

    get url(){
        return this.urlTarget.getAttribute("ref")
    }
    connect(){
        const ajaxEventListener = document.addEventListener("ajax:success", () => this.eventOnSuccess());
    }
    eventOnSuccess(){
        window.location = this.url
    }
    
    

          
      
}