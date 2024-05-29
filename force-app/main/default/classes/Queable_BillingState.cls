public class Queable_BillingState implements Queueable
{	
    public String state;
    public List<Contact> con;
    
    public Queable_BillingState(List<Contact> c,String s)
    {
        state = s;
        con = c;
    }
    
    public void execute(QueueableContext qc)
    {
        list<Account> accList = [select name , Billingstate from Account where Billingstate=:state limit 200] ;
    	
       	system.debug(accList);
    	
    	for(integer i=0;i<con.size();i++)
        {
           con[i].AccountId = accList[i].id ;
        }
        update con ;
    }
}