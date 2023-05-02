trigger JurisdictionAccountTrigger on JurisdictionAccount__c (after insert, after delete) {
    system.debug('in JurisdictionAccountTrigger');
    TriggerDispatcher.Run(new JurisdictionAccountTriggerHandler(), Trigger.operationType);

}
