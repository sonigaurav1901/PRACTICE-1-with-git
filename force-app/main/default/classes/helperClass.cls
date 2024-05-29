public class helperClass {
	public static void checkDuplicate(List<Contact> conList) {
		/*List<Contact> exsistingContact = [select  Id,LastName from contact];
        
        System.debug('exsisting records => '+exsistingContact);
		
		Set<String> contactNames = new Set<String>();
		for(Contact con: exsistingContact) {
			contactNames.add(String.valueOf(con.LastName));
		}
        System.debug('contactNames records => '+contactNames);
        
        Set<String> newNames = new Set<String>();
        for(Contact con:conList) {
            if(newNames.contains(con.LastName)) {
                con.addError('Insertin duplicate contact at same time');
            }
            else {
        		newNames.add(String.valueOf(con.LastName));        
            }
		}

		for(Contact con:conList) {
			if(contactNames.contains(con.LastName)){
                con.addError('duplicate contact');
			}
            
		}*/
		
	}
}