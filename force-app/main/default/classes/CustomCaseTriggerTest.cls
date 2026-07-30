@isTest
public class CustomCaseTriggerTest {
    @isTest
    public static void test01() {
        Account accTest = new Account(LastName='nakamura');
        accTest.PersonOtherState='TEST';
        accTest.PersonEmail='test@example.com';
        insert accTest;
        
        Case__c cc = new Case__c(Account__c = accTest.Id);
        List<User> users = NXI_Dao.getUsers();
        User userid ;
        for(User u:users){
            if(u.IsActive && u.UserCode__c!=null){
                userid = u;
                break;
            }
        }

        cc.OpportunityOwner__c =userid.Id;
       // cc.Grade__c = [Select Id From Grade__c ]
        cc.VehicleClassification__c ='はなまるオークション/他社AA（コール）';
        
        
        cc.CarNo__c ='test';
        cc.CarClass__c ='事故車';
        cc.CarClassRemark__c ='test';
        
        Mst_Models__c newmodel = new Mst_Models__c(Name='aaaa',inum__c='1111');
        insert newmodel;
        cc.CarTypes__c = newmodel.id;
        cc.Ownership__c ='なし';
        
        cc.OwnershipRemark__c ='test';
        cc.RegistrationNo__c ='test';
        cc.Amount__c =1111;
        cc.Engine__c ='かかる';
        
         cc.Shift__c ='AT';
        cc.Handle__c ='test';
        cc.Displacement__c =10000;
        cc.SelfPropulsion__c ='不可';
        cc.Tire__c ='転がらない';
        cc.DriveType__c ='test';
        cc.Owner__c ='test';
        cc.User__c ='test';
        
        cc.Moving__c ='1回';
        cc.Classification__c ='test';
        cc.Airbag__c ='ある';
        cc.AirbagPosition__c ='サイド';
        cc.ChangeLastName__c ='なし';
        
        cc.LiabilityAttachmentShipping__c ='取付不要';
        cc.Doors__c ='5';
        cc.Presence__c ='あり';
        cc.NecessaryDocument__c ='test';
        cc.Remarks__c ='test';
        
        cc.RecyclingFee__c =100000;
        cc.DocumentAttachmentShipping_Free__c ='売買契約書';
        cc.Image_existence_hs__c ='画像あり';
        cc.VehicleInspection__c ='車検あり（名変可）';
        cc.Inspection_year_hs__c ='2027';
        cc.Inspection_month_hs__c ='3月';
        
        cc.FirstRegistration_Year_hs__c ='2020';
        cc.FirstRegistration_Month_hs__c ='3月';
        cc.Mileage_hs__c =1000;
        cc.MileageUnit_hs__c ='km';
        cc.Color_hs__c ='パール系';
        
        cc.Pickup_Preferred_date1_hs__c =date.today();
        cc.Pickup_Preferred_date1_hs__c =date.today();
        cc.Pickup_Preferred_date2_hs__c =date.today();
        cc.Pickup_Preferred_date3_hs__c =date.today();
        cc.Document_Existence__c ='書類あり';
        
        cc.Auction_PickupRemarks_hs__c ='2020';
        cc.VehicleCondition_Supplement_hs__c ='自走積込OK';
        cc.StorageStatus_hs__c ='作業スペースOK';
        cc.EasyToContact_Timezone_hs__c ='2020';
        cc.ChangeColor_hs__c =true;
        
        cc.Option_hs__c ='AW';
        cc.StorageLocationTEL__c ='01';
        cc.LocationAddress_memo__c ='1000';
        cc.StorageLocationPerson__c ='2020';
        cc.StorageLocation__c ='test';
        
        cc.PickUpDate__c =date.today();
        cc.AfterDocuments_CompleteCheck__c =date.today();
        cc.ReceptionDateTime__c =datetime.now();
        cc.ListingEndsDate__c =date.today();
        cc.DocumentCompleteCheck__c =date.today();
        
        cc.TransferDate__c =date.today();
        cc.ContractCompletedDate__c =date.today();
        cc.CancellationPenalty__c ='請求要';
        cc.CancellationAfterSold__c =false;
            
        cc.WaitingCallA__c =true;
        cc.WaitingOpp__c =true;
        insert cc;
        
        cc.Heroku__c =true;
        
        update cc;
        
    }
}