import { LightningElement, track } from 'lwc';
import getNews from "@salesforce/apex/newsController.getNews";
export default class NewsComponent extends LightningElement {
    @track result = [];
    @track selectedNews={};
    @track isModalOpen = false;
    get modalClass(){
        return `slds-modal ${this.isModalOpen && 'slds-fade-in-open'}`;
    }
    get modalBackdropClass(){
        return `slds-backdrop ${this.isModalOpen && 'slds-backdrop_open'}`;
    }
    connectedCallback(){
        this.fetchNews();
    }
    fetchNews(){
        getNews().then(response=>{
            this.formatNewsData(response.articles)
        }).catch(error=>{
            console.error(error);
        });
    }

    formatNewsData(res){
        this.result = res.map((item, index)=>{
            let id = `new_${index+1}`;
            let date = new Date(item.publishedAt).toDateString();
            let name = item.source.name;
            return { ...item, id: id, name: name, date: date};
        });
    }

    showModal(event){
        let id = event.target.dataset.item;
        this.result.forEach(item=>{
            if(item.id === id){
                this.selectedNews = {...item};
            }
        })
        this.isModalOpen = true;
    }

    closeModal(){
        this.isModalOpen = false;
    }
}