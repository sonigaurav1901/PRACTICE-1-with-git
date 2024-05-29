public class creatingContact {
	public static void main()
    {
        integer count = [Select count() from Account where Billingstate='Rajasthan'];
        System.debug(count);
        List<Contact> con = new List<Contact>();
        for(integer i=0;i<count;i++)
        {
            Contact c = new Contact(lastname = 'theQable_Con'+i);
            con.add(c);
        }
        insert con;
        
        System.enqueueJob(new Queable_BillingState(con,'Rajasthan'));
    }
}