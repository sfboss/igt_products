public class JurisdictionAccountTriggerHandler implements ITriggerHandler {
 
    public static Boolean TriggerDisabled = false;
 
    public Boolean IsDisabled() {
 
      return TriggerDisabled;
    }
  
    public void BeforeInsert(List<SObject> newItems) {
      // Cast the Sobject[] to Account[]
    }
  
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
      // Cast the Map<Id, Sobject> to Account[]
    }
  
    public void BeforeDelete(Map<Id, SObject> oldItems) {}
  
    public void AfterInsert(Map<Id, SObject> newItems) {
        system.debug('in after insert');
        updateJurisdictionAccounts((JurisdictionAccount__c[])newItems.values());
    }
  
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {}
  
    public void AfterDelete(Map<Id, SObject> oldItems) {
        system.debug('in after delete');
        updateJurisdictionAccounts((JurisdictionAccount__c[])oldItems.values());
    }
  
    public void AfterUndelete(Map<Id, SObject> oldItems) {}
  
    public static void updateJurisdictionAccounts(JurisdictionAccount__c[] triggerNew) {
        // Create a set of all the JurisdictionAccount__c ids where Account is the Account__c id from triggerNew
        Set<String> jurisdictionAccountIds = new Set<String>();
        for (JurisdictionAccount__c ja : triggerNew) {
            jurisdictionAccountIds.add(ja.Account__c);
        }
        // Create a map of all the JurisdictionAccount__c records where Account is the Account__c id from triggerNew
        Map<String, JurisdictionAccount__c> jurisdictionAccounts = new Map<String, JurisdictionAccount__c>([SELECT Id, Account__c, Jurisdiction__c FROM JurisdictionAccount__c WHERE Account__c IN :jurisdictionAccountIds]);
        // create a map of accountIds to a set of Jurisdiction__c names
        Map<String, Set<String>> accountJurisdictions = new Map<String, Set<String>>();
        for (JurisdictionAccount__c ja : jurisdictionAccounts.values()) {
            if (!accountJurisdictions.containsKey(ja.Account__c)) {
                accountJurisdictions.put(ja.Account__c, new Set<String>());
            }
            accountJurisdictions.get(ja.Account__c).add(ja.Jurisdiction__c);
        }
        // create a list of accounts to update and update the Jurisdictions__c field with a csv list of the Jurisdiction__c names from the map values
        List<Account> accountsToUpdate = new List<Account>();
        for (String accId : accountJurisdictions.keySet()) {
            Account accountToUpdate = new Account(Id=accId, Jurisdictions__c=String.join(new List<String>(accountJurisdictions.get(accId)), ','));
            accountsToUpdate.add(accountToUpdate);
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
 


    }
  }
