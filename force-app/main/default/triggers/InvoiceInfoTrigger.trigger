trigger InvoiceInfoTrigger on Invoice_Info__c (before insert, before update) {
    InvoiceBusinessDayService.setInternalPaymentDeadline(Trigger.new);
}