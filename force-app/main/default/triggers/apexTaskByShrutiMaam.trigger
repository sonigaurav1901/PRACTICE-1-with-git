trigger apexTaskByShrutiMaam on Lead (before insert) 
{
    LeadHelperClasss.fetchRatio1(Trigger.new);
    //System.debug('Hello guys ');  
}