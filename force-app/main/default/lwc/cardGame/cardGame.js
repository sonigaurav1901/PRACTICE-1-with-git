import { LightningElement, track } from 'lwc';
import SetUser from '@salesforce/apex/Card_Game.UserInfo';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Card_Game extends LightningElement
{
    @track EnterGame = true
    @track UserCreate = false;
    @track ShowGameEasy     = false;
    @track ShowGameMedium   = false;
    @track ShowGameHard     = false;
    @track TimeEasy   = '00:00'
    @track TimeMedium = '00:00'
    @track TimeHard   = '00:00'
    downloadTimer;
    @track PlayerName = ''
    @track cardsrow1 = [];
    @track cardsrow2 = [];
    @track colors = ['crimson','lime','blue','orange'];
    @track comparearray = [];
    @track matched = [];
    @track score = 0;
    @track gameover = false;
    @track level = true;

    // user information.. 
    SaveUserInfo()
    {
        var UserName = this.template.querySelector(".UserName").value;
        console.log('UserName ', UserName);
        var UserEmail = this.template.querySelector(".UserEmail").value;
        console.log('UserEmail ', UserEmail);
        this.PlayerName = UserName;
        SetUser({ Name: UserName, Email: UserEmail })
            .then((result) => {
                    console.log(result);
                    this.UserCreate = result;
                    if (this.UserCreate)
                    {
                            this.UserCreate = result;
                    }
                    else if (!this.UserCreate) {
                            const toastEvent = new ShowToastEvent({
                                    title: '! Warning',
                                    message: ' User Already Exists :',
                                    variant: 'warning',
                            })
                            this.dispatchEvent(toastEvent);

                            // After warning reload page

                            this.EnterGame = true ;
                    }
            })
            .catch((error) => {
                    console.log(error);
            })
        this.EnterGame = false;
    }

    // Easy level code ..
    LevelEasy()
    {
        this.comparearray = [] ;
        // this.makeRandomCards();
        this.connectedCallback
        {
            if(this.score == 100)
            {
                    this.matched = []
                    this.comparearray = []
            }
        }
        this.ShowGameEasy   = true;
        this.ShowGameMedium = false;
        this.ShowGameHard   = false;
        this.UserCreate     = false;
        this.score = 0;
        var parentThis = this;
        this.TimeEasy = '120';
        var timeLeft = 0;
        let seconds
        clearInterval(parentThis.downloadTimer);
        this.downloadTimer = setInterval(function ()
        {
                if (timeLeft >= 120)
                {
                        clearInterval(parentThis.downloadTimer);
                        parentThis.ShowGameEasy = false;
                        const toastEvent = new ShowToastEvent({
                                title: 'Game Over',
                                message: `User Score : ${parentThis.score}`,
                                variant: 'warning',
                        })
                        parentThis.dispatchEvent(toastEvent)
                        parentThis.UserCreate = true;
                        timeLeft = 0 ;
                        this.ShowGameEasy = false ;
                }
                else if(parentThis.score == 100)
                {
                        clearInterval(parentThis.downloadTimer)
                        const toastEvent = new ShowToastEvent({
                                title: 'Game Over',
                                message: `User Score : ${parentThis.score}`,
                                variant: 'success',
                            })
                            parentThis.dispatchEvent(toastEvent)
                            parentThis.UserCreate = true;
                            timeLeft = 0 ;
                            this.ShowGameEasy = false ;
                    }
                    seconds = 120 - timeLeft;
                    const m = Math.floor((seconds % 3600) / 60);
                    const s = Math.round(seconds % 60);
                    console.log(m,' : ',s);
                    parentThis.TimeEasy = seconds
                    timeLeft += 1;
            }, 1000);
        }

        // Medium level code
        LevelMedium()
        {
            this.comparearray = [] ;
            // this.makeRandomCards();
            this.connectedCallback
            {
                if(this.score == 100)
                {
                        this.matched = []
                        this.comparearray = []
                }
            }

            this.ShowGameEasy   = false;
            this.ShowGameMedium = true;
            this.ShowGameHard   = false;
            this.UserCreate     = false;
            this.score =  0
            this.TimeHard = '60';
            var timeLeft = 1;
            var parentThis = this;
            clearInterval(parentThis.downloadTimer);
            this.downloadTimer = setInterval(function ()
            {
                if (timeLeft >= 60)
                {
                        clearInterval(parentThis.downloadTimer);
                        parentThis.ShowGameMedium = false;
                        const toastEvent = new ShowToastEvent({
                                title: 'Game Over',
                                message: `User Score : ${parentThis.score}`,
                                variant: 'warning',
                        })
                        parentThis.dispatchEvent(toastEvent)
                        parentThis.UserCreate = true ;
                        timeLeft = 0 ;
                        this.ShowGameMedium = false ;
                }
                else if(parentThis.score == 100)
                {
                        clearInterval(parentThis.downloadTimer)
                        const toastEvent = new ShowToastEvent({
                                title: 'Game Over',
                                message: `User Score : ${parentThis.score}`,
                                variant: 'success',
                        })
                        parentThis.dispatchEvent(toastEvent)
                        parentThis.UserCreate = true;
                        timeLeft = 0 ; 
                        this.ShowGameMedium = false ;
                }
                let seconds = 60 - timeLeft;
                // const m = Math.floor((seconds % 3600) / 60);
                // const s = Math.round(seconds % 60);
                //console.log(m,' : ',s);
                parentThis.TimeMedium = seconds
                timeLeft += 1;
            }, 1000);
        }

        // Hard level code ..
        LevelHard()
        {
            this.comparearray = [] ;
            // this.makeRandomCards();
            this.connectedCallback
            {
                if(this.score == 100)
                {
                        this.matched = []
                        this.comparearray = []
                }
            }

            this.ShowGameEasy   = false;
            this.ShowGameMedium = false;
            this.ShowGameHard   = true;
            this.UserCreate     = false;
            this.score =  0
            this.TimeHard = '30';
            var timeLeft = 1;
            var parentThis = this;
            clearInterval(parentThis.downloadTimer);
            this.downloadTimer = setInterval(function ()
            {
                if (timeLeft >= 30)
                {
                        clearInterval(parentThis.downloadTimer);
                        const toastEvent = new ShowToastEvent({
                                title: 'Game Over',
                                message: `User Score : ${parentThis.score}`,
                                variant: 'warning',
                        })
                        parentThis.dispatchEvent(toastEvent)
                        parentThis.UserCreate = true;
                        timeLeft = 0 ;
                        parentThis.ShowGameHard = false;
                        this.ShowGameHard = false ;
                }
                else if(parentThis.score == 100)
                {
                        clearInterval(parentThis.downloadTimer)
                        const toastEvent = new ShowToastEvent({
                                title: 'Game Over',
                                message: `User Score : ${parentThis.score}`,
                                variant: 'success',
                        })
                        parentThis.dispatchEvent(toastEvent)
                        parentThis.UserCreate = true;
                        timeLeft = 0 ;
                        this.ShowGameHard = false ;
                }
                let seconds = 30 - timeLeft;
                //const m = Math.floor((seconds % 3600) / 60);
                //const s = Math.round(seconds % 60);
                //console.log(m,' : ',s);
                parentThis.TimeHard = seconds
                timeLeft += 1;
            }, 1000);
        }

        // Connected callback ;

        connectedCallback(){
            
            this.makeRandomCards();

        }
        Click(event)
        {
            console.log(event.target);
            console.log(event.target.dataset.id);
            event.target.style = `background-color: ${event.target.dataset.id}; height: 150px; width: 100px;margin-left:3vh`;
            this.comparearray.push(event.target.dataset.id);
            console.log(this.comparearray, this.comparearray.length, this.comparearray.length == 3);
            if(this.score == 100)
            {
                this.matched = []
                this.comparearray = []
            }
            console.log('Compare Array : ',this.comparearray);
            if(this.comparearray.length == 3 || this.comparearray.length == 2)
            {
                console.log(this.comparearray[0]==this.comparearray[1],this.comparearray[1]==this.comparearray[2]);
                try {
                    
                    if(this.comparearray[0]==this.comparearray[1] && this.comparearray[1]==this.comparearray[2]){
                        console.log('matched');
                        this.score+=25;
                        if(this.matched.includes(this.comparearray[0])){
                        }
                        else{
                            this.matched.push(this.comparearray[0]);
                        }
                        this.comparearray = [];
                    }
                    else{
                        this.template.querySelectorAll('.card').forEach(element => {
                            if(this.matched.includes(element.dataset.id)){
                            }
                            else{
                                setTimeout(() => {
                                    element.style.backgroundColor = 'white';
                                    console.log('White');
                                }, 200);
                            }
                        });
                        this.comparearray = [];
                    }
                } catch (error) {
                    console.log(error);
                }
            }
        }


        makeRandomCards()
        {
            let set1 = new Set();
            while(set1.size<4){
                set1.add(this.colors[(Math.floor(Math.random()*4))]);
            }
            let set2 = new Set();
            while(set2.size<4){
                set2.add(this.colors[(Math.floor(Math.random()*4))]);
            }
            let set3 = new Set();
            while(set3.size<4){
                set3.add(this.colors[(Math.floor(Math.random()*4))]);
            }
            let listofsets = [];
            listofsets.push(set1);
            listofsets.push(set2);
            listofsets.push(set3);
            console.log(listofsets);
            let c=0;
            set1.forEach(element => {
                this.cardsrow1.push({color: element, name: 'card1'+c});
                c++;
            });
            let cc=2;
            set2.forEach(element => {
                if(cc>=1){
                    this.cardsrow1.push({color: element, name: 'card1'+c});
                    cc--;
                }
                else if(cc==0){
                    c=0;
                    this.cardsrow2.push({color: element, name: 'card2'+c});
                    cc--;
                }
                else{
                    this.cardsrow2.push({color: element, name: 'card2'+c});
                }
                c++;
            });
            set3.forEach(element => {
                this.cardsrow2.push({color: element, name: 'card2'+c});
                c++;
            });
            console.log(this.cardsrow1);
            console.log(this.cardsrow2);
        }
}