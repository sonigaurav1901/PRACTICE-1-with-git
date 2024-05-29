import { LightningElement,api } from 'lwc';

export default class Carosel extends LightningElement {
    slideIndex = 0;
    @api carouselData;
    rotation;

    connectedCallback(){
        let rotationInterval = setInterval(() => {
            this.slidePosition(this.carouselData[0].id);
            let pos = this.template.querySelector(`[data-id="${this.carouselData[0].id}"]`);
            if(this.carouselData != undefined){
                clearInterval(rotationInterval);
            }
            if(pos.classList.contains('deactive')){
                pos.classList.remove('deactive');
            }
            pos.classList.add('active');
    
            this.rotation = setInterval(() => {
                
                this.slidePosition(this.carouselData[this.slideIndex].id);
            }, 5000);
        }, 100);
    }

    renderedCallback() {
        this.template.querySelectorAll('.slide').forEach(slide =>{
            if(!(slide.dataset.href == "" || slide.dataset.href == null || slide.dataset.href == undefined)){
                slide.style.background = `url("${slide.dataset.href}") no-repeat`;
                slide.style.backgroundSize = "cover";
                slide.querySelector('.carouselContent').style.width = "50%";
                // slide.querySelector('.carouselContent').style.fontSize = "11px";
            }
        })

        
    }

    handleOpenSlide(event){
        this.slidePosition(event.target.dataset.id);
    }

    slidePosition(position){
        let parent = this.template.querySelector(`.slide[data-counter="${position}"]`).parentNode;
        let child = this.template.querySelector(`.slide[data-counter="${position}"]`);
        let slideIndex = Array.prototype.indexOf.call(parent.children, child);
        this.slideIndex = slideIndex;
        this.template.querySelector(`.slide[data-counter="${position}"]`).parentNode.scrollLeft = this.template.querySelector(`.slide[data-counter="${position}"]`).offsetLeft;

        this.slideIndex++;
        if(this.slideIndex >= this.carouselData.length)
            this.slideIndex = 0;
    }

    handleScrolling(event){
        let container = this.template.querySelector(".slides");

        [].slice.call(container.children).forEach((ele, index)=> {
            if (Math.abs(ele.getBoundingClientRect().left - container.getBoundingClientRect().left) < 10) {

                this.slideIndex = Number(ele.dataset.counter.replace('dot', ''));
                if(this.slideIndex == this.carouselData.length)
                    this.slideIndex = 0;

                this.template.querySelectorAll('.dot').forEach(dot =>{
                    if(dot.classList.contains('active')){
                        dot.classList.remove('active');
                    }
                    dot.classList.add('deactive')
                })
                let pos = this.template.querySelector(`[data-id="${ele.dataset.counter}"]`);
                if(pos.classList.contains('deactive')){
                    pos.classList.remove('deactive');
                }
                pos.classList.add('active');
                
            } else {
            }
        });

    }

}