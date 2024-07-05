trigger UptoFiveOpp on Opportunity (before insert,after update) {

    if(trigger.isBefore && trigger.isInsert) {
        // practiceOpportunityHelperController.validateOpp(trigger.new);
    }

}