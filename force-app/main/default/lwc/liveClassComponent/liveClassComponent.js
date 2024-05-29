import { LightningElement } from 'lwc';
import MyResource from '@salesforce/resourceUrl/zipForIcons';
// import userPlaceHolders from '@salesforce/resourceUrl/userPlaceHolders';
// import networkIconDNA from '@salesforce/resourceUrl/networkIconDNA';
// import cutomIconOfUser from '@salesforce/resourceUrl/cutomIconOfUser';
// import multiUser from '@salesforce/resourceUrl/multiUser';


export default class TaskBySuryaSir extends LightningElement {
    // DateTime = 'Date Time';
    // ClassName = 'Calss Name';
    // Description = 'Description';
    // User = 'User';
    // Network = 'Low/seated';
    // time = '30 min';

    user = MyResource+'/user.png';
    network = MyResource+'/network.png';
    clock = MyResource+'/clock.png';
    like = MyResource+'/like.png';
    multiUsers = MyResource+'/multiuser.png';

    
    // imgURL = userPlaceHolders;
    // networkImgURL = networkIconDNA ; 
    // cutomIconOfUser = multiUser ;

    data =  [
                // 1
                {'DateTime':'Tuesday At  10:00 AM  EST','ClassName':'DANCE FOR PARKINSONS','Description':'hjkjksa sdfnksdf sdj sadfl sdaj sd','User':'Ayush','Network':'Low/Stated','time':'30 min','countOfJoinies' : '+6'},
                // 2
                {'DateTime':'Monday At  11:00 AM  EST','ClassName':'SALESFORCE ADMIN','Description':'hjkjksa sdfnksdf sdj sadfl sdaj sd','User':'Charchit','Network':'Medium/Stated','time':'45 min','countOfJoinies' : '+4'},
                //3
                {'DateTime':'Friday At  9:00 AM  EST','ClassName':'SALESFORCE DEVLOPER','Description':'jjllsaf jslkfj sdafj;l sadfjjsf ljsd','User':'alock','Network':'High/Stated','time':'35 min','countOfJoinies' : '+7'},
                //4
                {'DateTime':'Thursday At  1:00 PM  EST','ClassName':'ART AND CULTURE','Description':'jjllsaf jslkfj sdafj;l sadfjjsf ljsd','User':'Gaurav','Network':'Medium/Stated','time':'60 min','countOfJoinies' : '+2'},
            ];

    clockIcon()
    {
        console.log('clockIcon icon');
    }
    networkIcon()
    {
        console.log('networkIcon icon');
    }
    shareIcon()
    {
        console.log('Share icon');
    }
    favIcon()
    {
        console.log('favIcon icon');
    }
    joinButton()
    {
        console.log('joinButton icon');
    }
    userIcon()
    {
        console.log('user icon');
    }
}