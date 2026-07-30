public class NXI_TransferCustomCase {
    public static void NXI_TransferCustomCase(){
    }
    //買取受付起点
    public  void Translation(List<ID> targetIdList){
        
        List<Case__c> targetCC = NXI_Dao.getCustomCase(targetIdList);
        
        If(targetCC.size()>0){
            List<WorkExchange__c> newWorks = new List<WorkExchange__c >();
            
            for(Case__c buff:targetCC){
                
                WorkExchange__c newWorkRecord = new WorkExchange__c();
                
                newWorkRecord.OwnerId = buff.OwnerId;
                newWorkRecord.IsSynchronized__c = TRUE ;
                newWorkRecord.Id_Case__c = (String)buff.Id ;
                
                if(buff.CallAOpportunity__c!=null) newWorkRecord.Id_CallA__c = (String)buff.CallAOpportunity__c  ;
                if(buff.Oppotunity__c!=null) newWorkRecord.Id_Oppotunity__c = (String)buff.Oppotunity__c   ;
                newWorkRecord.Name_Case__c = buff.Name;
                newWorkRecord.CallA_IsCreated__c = buff.CallA_IsCreated__c;
                if(buff.PurchaseReception_LOT__c!=null) newWorkRecord.PurchaseReception_LOT__c = buff.PurchaseReception_LOT__c;
                if(buff.OldLotNo__c!=null) newWorkRecord.OldLotNo__c = buff.OldLotNo__c;
                newWorkRecord.Phase__c =buff.Phase__c;
                
                if(buff.CallAOpportunity__r.Phase__c!=null)newWorkRecord.CallAPhase__c=buff.CallAOpportunity__r.Phase__c;
                
                if(buff.Oppotunity__r.Phase__c!=null)newWorkRecord.OppotunityPhase__c=buff.Oppotunity__r.Phase__c;
                
                if(buff.VehicleClassification__c!=null) newWorkRecord.VehicleClassification__c = buff.VehicleClassification__c;
                if(buff.Maker__c!=null) newWorkRecord.Maker__c=buff.Maker__c;
                if(buff.CarTypes__c!=null) newWorkRecord.CarTypes__c=buff.CarTypes__c;
                
                if(buff.Grades__c!=null)newWorkRecord.GradeText__c=buff.Grades__r.Name;
                //if(buff.Grades__c!=null)newWorkRecord.Grades__c=buff.Grades__c;
                
                if(buff.VehicleInspection__c !=null) newWorkRecord.VehicleInspection__c=buff.VehicleInspection__c;
                if(buff.CarNo__c!=null) newWorkRecord.CarNo__c=buff.CarNo__c;
                if(buff.CarClass__c!=null) newWorkRecord.CarClass__c=buff.CarClass__c;
                if(buff.CarClassRemark__c!=null) newWorkRecord.CarClassRemark__c=buff.CarClassRemark__c;
                if(buff.Ownership__c!=null) newWorkRecord.Ownership__c=buff.Ownership__c;
                if(buff.OwnershipRemark__c!=null) newWorkRecord.OwnershipRemark__c=buff.OwnershipRemark__c;
                if(buff.RegistrationNo__c!=null) newWorkRecord.RegistrationNo__c=buff.RegistrationNo__c;
                if(buff.Amount__c!=null) newWorkRecord.Amount__c=buff.Amount__c;
                if(buff.Engine__c!=null) newWorkRecord.Engine__c=buff.Engine__c;
                if(buff.Shift__c!=null) newWorkRecord.Shift__c=buff.Shift__c;
                if(buff.Handle_hs__c !=null) newWorkRecord.Handle__c=buff.Handle_hs__c;
                if(buff.Displacement__c!=null) newWorkRecord.Displacement__c=buff.Displacement__c;
                if(buff.SelfPropulsion__c!=null) newWorkRecord.SelfPropulsion__c=buff.SelfPropulsion__c;
                if(buff.Tire__c!=null) newWorkRecord.Tire__c=buff.Tire__c;
                if(buff.DriveType__c!=null) newWorkRecord.DriveType__c=buff.DriveType__c;
                if(buff.Model__c!=null) newWorkRecord.Model__c=buff.Model__c;
                if(buff.Owner__c!=null) newWorkRecord.Owner__c=buff.Owner__c;
                if(buff.User__c!=null) newWorkRecord.User__c=buff.User__c;
                // 数式if(buff.CallAOpportunity__r.LocationAddress_hs__c!=null)newWorkRecord.LocationAddress_hs__c=buff.CallAOpportunity__r.LocationAddress_hs__c;
                if(buff.Moving__c!=null) newWorkRecord.Moving__c=buff.Moving__c;
                if(buff.Account__r.LastName!=null) newWorkRecord.LastName__c=buff.Account__r.LastName;
                if(buff.Classification__c!=null) newWorkRecord.Classification__c=buff.Classification__c;
                if(buff.Airbag__c!=null) newWorkRecord.Airbag__c=buff.Airbag__c;
                if(buff.AirbagPosition__c!=null) newWorkRecord.AirbagPosition__c=buff.AirbagPosition__c;
                if(buff.ChangeLastName__c!=null) newWorkRecord.ChangeLastName__c=buff.ChangeLastName__c;
                if(buff.LiabilityAttachmentShipping__c!=null) newWorkRecord.LiabilityAttachmentShipping__c=buff.LiabilityAttachmentShipping__c;
                if(buff.Doors__c!=null) newWorkRecord.Doors__c=buff.Doors__c;
                if(buff.Presence__c!=null) newWorkRecord.Presence__c=buff.Presence__c;
                if(buff.NecessaryDocument__c!=null) newWorkRecord.NecessaryDocument__c=buff.NecessaryDocument__c;
                if(buff.Remarks__c!=null) newWorkRecord.Remarks__c=buff.Remarks__c;
                if(buff.RecyclingFee__c!=null) newWorkRecord.RecyclingFee__c=buff.RecyclingFee__c;
                if(buff.DocumentAttachmentShipping_Free__c!=null) newWorkRecord.DocumentAttachmentShipping_Free__c=buff.DocumentAttachmentShipping_Free__c;
                if(buff.Image_existence_hs__c!=null) newWorkRecord.Image_existence_hs__c=buff.Image_existence_hs__c;
                if(buff.Inspection_year_hs__c!=null) newWorkRecord.Inspection_year_hs__c=buff.Inspection_year_hs__c;
                if(buff.Inspection_month_hs__c!=null) newWorkRecord.Inspection_month_hs__c=buff.Inspection_month_hs__c;
                if(buff.FirstRegistration_Year_hs__c!=null) newWorkRecord.FirstRegistration_Year_hs__c=buff.FirstRegistration_Year_hs__c;
                if(buff.FirstRegistration_Month_hs__c!=null) newWorkRecord.FirstRegistration_Month_hs__c=buff.FirstRegistration_Month_hs__c;
                if(buff.Mileage_hs__c!=null) newWorkRecord.Mileage_hs__c=buff.Mileage_hs__c;
                if(buff.MileageUnit_hs__c!=null) newWorkRecord.MileageUnit_hs__c=buff.MileageUnit_hs__c;
                if(buff.Color_hs__c!=null) newWorkRecord.Color_hs__c=buff.Color_hs__c;
                if(buff.VehicleCondition_hs__c!=null) newWorkRecord.VehicleCondition_hs__c=buff.VehicleCondition_hs__c;
                if(buff.Pickup_Preferred_date1_hs__c!=null) newWorkRecord.Pickup_Preferred_date1_hs__c=buff.Pickup_Preferred_date1_hs__c;
                if(buff.Pickup_Preferred_date2_hs__c!=null) newWorkRecord.Pickup_Preferred_date2_hs__c=buff.Pickup_Preferred_date2_hs__c;
                if(buff.Pickup_Preferred_date3_hs__c!=null) newWorkRecord.Pickup_Preferred_date3_hs__c=buff.Pickup_Preferred_date3_hs__c;
                if(buff.Document_Existence__c!=null) newWorkRecord.Document_Existence__c=buff.Document_Existence__c;
                if(buff.Auction_PickupRemarks_hs__c!=null) newWorkRecord.Auction_PickupRemarks_hs__c=buff.Auction_PickupRemarks_hs__c;
                if(buff.VehicleCondition_Supplement_hs__c!=null) newWorkRecord.VehicleCondition_Supplement_hs__c=buff.VehicleCondition_Supplement_hs__c;
                if(buff.StorageStatus_hs__c!=null) newWorkRecord.StorageStatus_hs__c=buff.StorageStatus_hs__c;
                if(buff.EasyToContact_Timezone_hs__c!=null) newWorkRecord.EasyToContact_Timezone_hs__c=buff.EasyToContact_Timezone_hs__c;
                if(buff.ChangeColor_hs__c!=null) newWorkRecord.ChangeColor_hs__c=buff.ChangeColor_hs__c;
                if(buff.Option_hs__c!=null) newWorkRecord.Option_hs__c=buff.Option_hs__c;
                
                //追加
                if(buff.Account__c!=null) newWorkRecord.Id_Account__c=buff.Account__c;
                if(buff.Account__r.Name!=null && buff.Account__r.IsPerson__c  != true) newWorkRecord.AccountName__c=buff.Account__r.Name;
                if(buff.Account__r.Name_kana__c!=null) newWorkRecord.Name_kana__c=buff.Account__r.Name_kana__c;
                if(buff.Account__r.Fax!=null) newWorkRecord.Fax__c=buff.Account__r.Fax;
                if(buff.Account__r.CorporationName__c!=null) newWorkRecord.CorporationName__c=buff.Account__r.CorporationName__c;
                if(buff.Account__r.FirstName!=null) newWorkRecord.FirstName__c=buff.Account__r.FirstName;
                if(buff.Account__r.PersonEmail!=null) newWorkRecord.PersonEmail__c=buff.Account__r.PersonEmail;
                if(buff.Account__r.PersonMobilePhone!=null) newWorkRecord.PersonMobilePhone__c=buff.Account__r.PersonMobilePhone;
                
                if(buff.Account__r.PersonMailingCity!=null) newWorkRecord.PersonMailingCity__c=buff.Account__r.PersonMailingCity;
                if(buff.Account__r.PersonOtherCity!=null) newWorkRecord.PersonOtherCity__c=buff.Account__r.PersonOtherCity;
                if(buff.SameAsAccountAddress_hs__c && buff.Account__r.PersonMailingCity!=null) newWorkRecord.PersonOtherCity__c=buff.Account__r.PersonMailingCity;
                
                //数式if(buff.Account__r.PersonMailingAddress!=null) newWorkRecord.PersonMailingAddress__c=buff.Account__r.PersonMailingAddress;
                if(buff.Account__r.PersonOtherStreet!=null) newWorkRecord.PersonOtherStreet__c=buff.Account__r.PersonOtherStreet;
                if(buff.Account__r.PersonMailingStreet!=null) newWorkRecord.PersonMailingStreet__c=buff.Account__r.PersonMailingStreet;
                if(buff.SameAsAccountAddress_hs__c && buff.Account__r.PersonMailingStreet!=null) newWorkRecord.PersonOtherStreet__c=buff.Account__r.PersonMailingStreet;
                
                if(buff.Account__r.PersonOtherState!=null) newWorkRecord.PersonOtherState__c=buff.Account__r.PersonOtherState;
                if(buff.Account__r.PersonMailingState!=null) newWorkRecord.PersonMailingState__c=buff.Account__r.PersonMailingState;
                 if(buff.SameAsAccountAddress_hs__c && buff.Account__r.PersonMailingStreet!=null) newWorkRecord.PersonOtherState__c=buff.Account__r.PersonMailingState;
                
                
                if(buff.StorageLocationTEL__c!=null) newWorkRecord.StorageLocationTEL__c=buff.StorageLocationTEL__c;
                if(buff.LocationAddress_memo__c!=null) newWorkRecord.LocationAddress_memo__c=buff.LocationAddress_memo__c;
                if(buff.StorageLocationPerson__c!=null) newWorkRecord.StorageLocationPerson__c=buff.StorageLocationPerson__c;
                if(buff.StorageLocation__c!=null) newWorkRecord.StorageLocation__c=buff.StorageLocation__c;
                
                if(buff.Account__r.PersonOtherPostalCode!=null) newWorkRecord.PersonOtherPostalCode__c=buff.Account__r.PersonOtherPostalCode;
                if(buff.SameAsAccountAddress_hs__c && buff.Account__r.PersonMailingPostalCode!=null) newWorkRecord.PersonOtherPostalCode__c=buff.Account__r.PersonMailingPostalCode;
                if(buff.Account__r.PersonMailingPostalCode!=null) newWorkRecord.PersonMailingPostalCode__c=buff.Account__r.PersonMailingPostalCode;
                
                if(buff.PickUpDate__c!=null) newWorkRecord.PickUpDate__c=buff.PickUpDate__c;
                if(buff.AfterDocuments_CompleteCheck__c!=null) newWorkRecord.AfterDocuments_CompleteCheck__c=buff.AfterDocuments_CompleteCheck__c;
                
                if(buff.Oppotunity__r.CreatedDate!=null)newWorkRecord.CreatedDate__c=buff.Oppotunity__r.CreatedDate;
                
                if(buff.ReceptionDateTime__c!=null) newWorkRecord.ReceptionDateTime__c=buff.ReceptionDateTime__c;
                if(buff.ListingEndsDate__c!=null) newWorkRecord.ListingEndsDate__c=buff.ListingEndsDate__c;
                if(buff.DocumentCompleteCheck__c!=null) newWorkRecord.DocumentCompleteCheck__c=buff.DocumentCompleteCheck__c;
                if(buff.TransferDate__c!=null) newWorkRecord.TransferDate__c=buff.TransferDate__c;
                
                if(buff.Oppotunity__r.CompletionDate__c!=null)newWorkRecord.CompletionDate__c=buff.Oppotunity__r.CompletionDate__c;
                
                if(buff.ContractCompletedDate__c!=null) newWorkRecord.ContractCompletedDate__c=buff.ContractCompletedDate__c;
                
                if(buff.Oppotunity__r.CancelDate__c!=null)newWorkRecord.CancelDate__c=buff.Oppotunity__r.CancelDate__c;
                //if(buff.Oppotunity__r.CancelReason__c!=null)newWorkRecord.CancelReason__c=buff.Oppotunity__r.CancelReason__c;
                
                //if(buff.CancellationPenalty__c!=null) newWorkRecord.CancellationPenalty__c=buff.CancellationPenalty__c;
                if(buff.Cancellation_reason__c!=null) newWorkRecord.Cancellation_reason__c=buff.Cancellation_reason__c;
                if(buff.CancellationAfterSold__c!=null) newWorkRecord.CancellationAfterSold__c=buff.CancellationAfterSold__c;
                if(buff.CancellationAfterPurchased__c!=null) newWorkRecord.CancellationAfterPurchased__c=buff.CancellationAfterPurchased__c;                
                if(buff.Owner_Fullname__c!=null) newWorkRecord.Owner_Fullname__c=buff.Owner_Fullname__c;                
                
                if(buff.UserCode__c!=null) newWorkRecord.UserCode__c=buff.UserCode__c;
                if(buff.Desired_amount_hs__c!=null) newWorkRecord.Desired_amount_hs__c=buff.Desired_amount_hs__c;
                
                newWorks.add(newWorkRecord);
                buff.WaitingCallA__c = false;
                buff.WaitingOpp__c = false;
                buff.Heroku__c = false;
                
            }
            if(newWorks.size()>0){
                upsert newWorks Id_Case__c;
                update targetCC;
            }
        }
    }
    //連携テーブル起点
    public  void Receive(List<ID> targetIdList){
        List<WorkExchange__c> targetWE = NXI_Dao.getWorkExchange(targetIdList);
        If(targetWE.size()>0){
            system.debug('反映開始');
            List<Id> ccList = new List<Id>();
            List<Id> poList = new List<Id>();
            List<Id> caList = new List<Id>();
            List<Id> accList = new List<Id>();
            
            
            //連携されてきたId採取
            for(WorkExchange__c buff:targetWE){
                if(buff.Id_Case__c !=null &&(! ccList.contains((ID)buff.Id_Case__c)))  ccList.add(buff.Id_Case__c);
                if(buff.Id_Oppotunity__c !=null &&(! poList.contains((ID)buff.Id_Oppotunity__c)))  poList.add(buff.Id_Oppotunity__c);
                if(buff.Id_CallA__c !=null &&(! caList.contains((ID)buff.Id_CallA__c)))  caList.add(buff.Id_CallA__c);
                if(buff.Id_Account__c !=null &&(! accList.contains((ID)buff.Id_Account__c)))  accList.add(buff.Id_Account__c);
            }
            //反映先リスト作成
            List<Case__c> targetListCc = [Select Id From Case__c Where Id IN :ccList];
            List<String>  ccstrList = new List<String>();
            for(Case__c cc: targetListCc){
                ccstrList.add((String)cc.Id);
            }
            List<PurchaseOpportunity__c> targetListPo =[Select Id From PurchaseOpportunity__c Where Id IN :poList];
            List<String>  postrList = new List<String>();
            for(PurchaseOpportunity__c po: targetListPo){
                postrList.add((String)po.Id);
            }
            List<CallCenterA_Opportunity__c> targetListCa  =[Select Id From CallCenterA_Opportunity__c Where Id IN :caList];
            List<String>  castrList = new List<String>();
            for(CallCenterA_Opportunity__c ca: targetListCa){
                castrList.add((String)ca.Id);
            }
            List<Account> targetListAcc  =[Select Id From Account Where Id IN :accList];
            List<String>  accstrList = new List<String>();
            for(Account acc: targetListAcc){
                accstrList.add((String)acc.Id);
            }
            
            //反映用レコードリスト
            List<Case__c> newCcs = new List<Case__c >();
            List<PurchaseOpportunity__c> newPos = new List<PurchaseOpportunity__c >();
            List<CallCenterA_Opportunity__c> newCas = new List<CallCenterA_Opportunity__c >();
            List<Account> newAccs = new List<Account >();
            List<WorkExchange__c> exToTrueList = new List<WorkExchange__c>(); 
            //反映開始
            for(WorkExchange__c buff:targetWE){
                Case__c newCase = new Case__c();
                PurchaseOpportunity__c newPurchaseOpportunity = new PurchaseOpportunity__c();
                CallCenterA_Opportunity__c newCallCenterA_Opportunity = new CallCenterA_Opportunity__c();
                Account newAccount = new Account();
                
                WorkExchange__c ex = new WorkExchange__c();
                ex.IsSynchronized__c=true;
                ex.Id_Case__c =buff.Id_Case__c;
                //exToTrueList.add(ex);
                
                if(ccstrList.contains(buff.Id_Case__c)) newCase.Id= (ID)buff.Id_Case__c;
                if(postrList.contains(buff.Id_Oppotunity__c)) newPurchaseOpportunity.Id= (ID)buff.Id_Oppotunity__c;
                if(castrList.contains(buff.Id_CallA__c)) newCallCenterA_Opportunity.Id= (ID)buff.Id_CallA__c;
                if(accstrList.contains(buff.Id_Account__c)) newAccount.Id= (ID)buff.Id_Account__c;
                
                // 読み込み専用　if(buff.PurchaseReception_LOT__c!=null) newCase.PurchaseReception_LOT__c = buff.PurchaseReception_LOT__c;
                if(buff.OldLotNo__c!=null) newCase.OldLotNo__c = buff.OldLotNo__c;
                system.debug('買取受付フェーズ '+buff.Phase__c);
                if(buff.Phase__c!=null) newCase.Phase__c = buff.Phase__c;
                system.debug('CALLAフェーズ '+buff.CallAPhase__c);
                if(buff.CallAPhase__c!=null) newCallCenterA_Opportunity.Phase__c = buff.CallAPhase__c;
                system.debug('買取商談フェーズ '+buff.OppotunityPhase__c);
                if(buff.OppotunityPhase__c!=null) newPurchaseOpportunity.Phase__c = buff.OppotunityPhase__c;
                /*
                if(buff.Phase__c!= null){
                    switch on buff.Phase__c {
                        when 'はなまる保留' {    
                            newCase.Phase__c = '廃車保留';
                        }  
                        when '売契済保留' {    
                            newCase.Phase__c = '廃車保留';
                        }
                        when 'ア待ち' {
                            newCase.Phase__c = '出品待ち';
                            newPurchaseOpportunity.Phase__c = '買取';
                            newCallCenterA_Opportunity.Phase__c ='ア待ち';
                        }
                        when 'ア済み' {
                            newCase.Phase__c = '出品待ち';
                            newPurchaseOpportunity.Phase__c = '買取';
                            newCallCenterA_Opportunity.Phase__c ='ア済み';
                        }
                        when '売契待ち' {
                            newCase.Phase__c = '出品待ち';
                            newPurchaseOpportunity.Phase__c = '買取';
                            newCallCenterA_Opportunity.Phase__c ='売契待ち';
                        }
                        when '確定待ち' {
                            newCase.Phase__c = '出品待ち';
                            newPurchaseOpportunity.Phase__c = '買取';
                            newCallCenterA_Opportunity.Phase__c ='売契待ち';
                        }
                        when '出品待ち' {
                            newCase.Phase__c = '出品待ち';
                            newPurchaseOpportunity.Phase__c = '買取';
                        }
                        when 'ライブ出品中' {
                            newCase.Phase__c = '出品中';
                            newPurchaseOpportunity.Phase__c = '買取';
                        }
                        when '即決未設定' {
                            newCase.Phase__c = '出品中';
                            newPurchaseOpportunity.Phase__c = '買取';
                        }
                        when '即決出品中' {
                            newCase.Phase__c = '出品中';
                            newPurchaseOpportunity.Phase__c = '買取';
                        }
                        when '提携売却未定' {
                            newCase.Phase__c = '商談中';
                            newPurchaseOpportunity.Phase__c = '買取';
                        }
                        when 'ライブ売却' {
                            newCase.Phase__c = '売却';
                            newPurchaseOpportunity.Phase__c = '買取';
                        }
                        when '即決売却' {
                            newCase.Phase__c = '売却';
                            newPurchaseOpportunity.Phase__c = '買取';
                        }
                        when '提携売却' {
                            newCase.Phase__c = '売却';
                            newPurchaseOpportunity.Phase__c = '買取';
                        }
                        when '売却/全完了' {
                            newPurchaseOpportunity.Phase__c = '全完了';
                        }
                        when 'キャンセル' {
                            newPurchaseOpportunity.Phase__c = '全完了';
                        }
                    }
                }*/
                if(buff.VehicleClassification__c!=null) newCase.VehicleClassification__c = buff.VehicleClassification__c;
                if(buff.Maker__c!=null) newCase.Maker__c=buff.Maker__c;
                if(buff.CarTypes__c!=null){
                    newCase.CarTypes__c=buff.CarTypes__c; 
                    newPurchaseOpportunity.CarName__c=buff.txtCarType__c ;
                    newCallCenterA_Opportunity.CarName__c=buff.txtCarType__c ;
                } 
                if(buff.GradeText__c !=null){
                    newCase.Grade__c = buff.GradeText__c;
                    newPurchaseOpportunity.Grade__c = buff.GradeText__c;
                    newCallCenterA_Opportunity.Grade__c = buff.GradeText__c;
                }
                
                if(buff.VehicleInspection__c !=null) newCase.VehicleInspection__c = buff.VehicleInspection__c;
                if(buff.CarNo__c !=null) 
                {
                    newCase.CarNo__c = buff.CarNo__c;
                    newPurchaseOpportunity.CarNo__c = buff.CarNo__c;
                    newCallCenterA_Opportunity.CarNo__c = buff.CarNo__c;
                }
                if(buff.CarClass__c !=null) 
                {
                    newCase.CarClass__c = buff.CarClass__c;
                    newPurchaseOpportunity.State__c = buff.CarClass__c;
                    newCallCenterA_Opportunity.CarClass__c = buff.CarClass__c;
                }
                if(buff.CarClassRemark__c !=null)   newCase.CarClassRemark__c = buff.CarClassRemark__c;
                if(buff.Ownership__c !=null) 
                {
                    newCase.Ownership__c = buff.Ownership__c;
                    newCallCenterA_Opportunity.Ownership__c = buff.Ownership__c;
                }
                if(buff.OwnershipRemark__c !=null) newCase.OwnershipRemark__c = buff.OwnershipRemark__c;
                if(buff.RegistrationNo__c !=null) 
                {
                    newCase.RegistrationNo__c = buff.RegistrationNo__c;
                    newCallCenterA_Opportunity.RegistrationNo__c = buff.RegistrationNo__c;
                }
                if(buff.Amount__c !=null) 
                {
                    newCase.Amount__c = buff.Amount__c;
                    newCallCenterA_Opportunity.Amount__c = buff.Amount__c;
                }
                
                if(buff.Engine__c!=null) newCase.Engine__c=buff.Engine__c;
                if(buff.Shift__c!=null) newCase.Shift__c=buff.Shift__c;
                if(buff.Handle__c!=null) newCase.Handle_hs__c =buff.Handle__c;
                if(buff.Displacement__c!=null) {
                    newCase.Displacement__c=buff.Displacement__c;
                    newCallCenterA_Opportunity.Displacement__c = buff.Displacement__c;
                }
                
                if(buff.SelfPropulsion__c!=null) newCase.SelfPropulsion__c=buff.SelfPropulsion__c;
                if(buff.Tire__c!=null) newCase.Tire__c=buff.Tire__c;
                if(buff.DriveType__c!=null) newCase.DriveType__c=buff.DriveType__c;
                if(buff.Model__c!=null) newCase.Model__c=buff.Model__c;
                
                if(buff.Owner__c!=null) 
                {
                    newCase.Owner__c=buff.Owner__c;
                    newCallCenterA_Opportunity.Owner__c = buff.Owner__c;
                }
                if(buff.User__c!=null)   {
                    newCase.User__c=buff.User__c;
                    newCallCenterA_Opportunity.User__c = buff.User__c;
                }
                if(buff.Moving__c!=null)  {
                    newCase.Moving__c=buff.Moving__c;
                    newCallCenterA_Opportunity.Moving__c = buff.Moving__c;
                }
                
                //LastName
                if(buff.LastName__c!=null) newAccount.LastName=buff.LastName__c;
                
                if(buff.Classification__c!=null) newCase.Classification__c=buff.Classification__c;
                if(buff.Airbag__c!=null) newCase.Airbag__c=buff.Airbag__c;
                if(buff.AirbagPosition__c!=null) newCase.AirbagPosition__c=buff.AirbagPosition__c;
                
                if(buff.ChangeLastName__c!=null) {
                    newCase.ChangeLastName__c=buff.ChangeLastName__c;
                    newCallCenterA_Opportunity.ChangeLastName__c=buff.ChangeLastName__c;
                }
                if(buff.LiabilityAttachmentShipping__c!=null) newCase.LiabilityAttachmentShipping__c=buff.LiabilityAttachmentShipping__c;
                if(buff.Doors__c!=null) newCase.Doors__c=buff.Doors__c;
                if(buff.Presence__c!=null) newCase.Presence__c=buff.Presence__c;
                if(buff.NecessaryDocument__c!=null) newCase.NecessaryDocument__c=buff.NecessaryDocument__c;
                if(buff.Remarks__c!=null) newCase.Remarks__c=buff.Remarks__c;
                
                if(buff.RecyclingFee__c!=null) {
                    newCase.RecyclingFee__c = buff.RecyclingFee__c;
                    newPurchaseOpportunity.RecyclingFee__c = buff.RecyclingFee__c;
                    newCallCenterA_Opportunity.RecyclingFee__c = buff.RecyclingFee__c;
                }
                
                if(buff.DocumentAttachmentShipping_Free__c!=null) newCase.DocumentAttachmentShipping_Free__c=buff.DocumentAttachmentShipping_Free__c;
                if(buff.Image_existence_hs__c!=null) newCase.Image_existence_hs__c=buff.Image_existence_hs__c;
                if(buff.Inspection_year_hs__c!=null) newCase.Inspection_year_hs__c=buff.Inspection_year_hs__c;
                if(buff.Inspection_month_hs__c!=null) newCase.Inspection_month_hs__c=buff.Inspection_month_hs__c;
                
                
                if(buff.FirstRegistration_Year_hs__c!=null) {
                    newCase.FirstRegistration_Year_hs__c = buff.FirstRegistration_Year_hs__c;
                    newPurchaseOpportunity.ModelYearPickList__c  = buff.FirstRegistration_Year_hs__c ;
                    newCallCenterA_Opportunity.FirstRegistration_Year_hs__c = buff.FirstRegistration_Year_hs__c;
                }
                
                if(buff.FirstRegistration_Month_hs__c!=null) {
                    newCase.FirstRegistration_Month_hs__c = buff.FirstRegistration_Month_hs__c;
                    newCallCenterA_Opportunity.FirstRegistration_Month_hs__c = buff.FirstRegistration_Month_hs__c;
                }
                
                if(buff.Mileage_hs__c!=null) {
                    newCase.Mileage_hs__c = buff.Mileage_hs__c;
                    newCallCenterA_Opportunity.Mileage_hs__c = buff.Mileage_hs__c;
                }
                if(buff.MileageUnit_hs__c!=null){
                    newCase.MileageUnit_hs__c = buff.MileageUnit_hs__c;
                    newCallCenterA_Opportunity.MileageUnit_hs__c = buff.MileageUnit_hs__c;
                }
                if(buff.Color_hs__c!=null) newCase.Color_hs__c=buff.Color_hs__c;
                if(buff.VehicleCondition_hs__c!=null) newCase.VehicleCondition_hs__c=buff.VehicleCondition_hs__c;
                if(buff.Pickup_Preferred_date1_hs__c!=null && buff.VehicleClassification__c!='はなまるオークション/他社AA（コール）') newCase.Pickup_Preferred_date1_hs__c=buff.Pickup_Preferred_date1_hs__c;
                if(buff.Pickup_Preferred_date2_hs__c!=null && buff.VehicleClassification__c!='はなまるオークション/他社AA（コール）') newCase.Pickup_Preferred_date2_hs__c=buff.Pickup_Preferred_date2_hs__c;
                if(buff.Pickup_Preferred_date3_hs__c!=null && buff.VehicleClassification__c!='はなまるオークション/他社AA（コール）') newCase.Pickup_Preferred_date3_hs__c=buff.Pickup_Preferred_date3_hs__c;
                if(buff.Document_Existence__c!=null) newCase.Document_Existence__c=buff.Document_Existence__c;
                if(buff.Auction_PickupRemarks_hs__c!=null) newCase.Auction_PickupRemarks_hs__c=buff.Auction_PickupRemarks_hs__c;
                if(buff.VehicleCondition_Supplement_hs__c!=null) newCase.VehicleCondition_Supplement_hs__c=buff.VehicleCondition_Supplement_hs__c;
                if(buff.StorageStatus_hs__c!=null) newCase.StorageStatus_hs__c=buff.StorageStatus_hs__c;
                if(buff.EasyToContact_Timezone_hs__c!=null) newCase.EasyToContact_Timezone_hs__c=buff.EasyToContact_Timezone_hs__c;
                if(buff.ChangeColor_hs__c!=null) newCase.ChangeColor_hs__c=buff.ChangeColor_hs__c;
                if(buff.Option_hs__c!=null) newCase.Option_hs__c=buff.Option_hs__c;
                
                //追加
                // IDは最初に判定済み
                //if(buff.AccountName__c!=null) newAccount.Name=buff.AccountName__c;
                if(buff.Name_kana__c!=null) newAccount.Name_kana__c=buff.Name_kana__c;
                if(buff.Fax__c!=null) newAccount.Fax=buff.Fax__c;
                if(buff.CorporationName__c!=null) newAccount.CorporationName__c=buff.CorporationName__c;
                if(buff.FirstName__c!=null) newAccount.FirstName=buff.FirstName__c;
                if(buff.PersonEmail__c!=null) newAccount.PersonEmail=buff.PersonEmail__c;
                if(buff.PersonMailingCity__c!=null) newAccount.PersonMailingCity=buff.PersonMailingCity__c;
                if(buff.PersonMobilePhone__c!=null) newAccount.PersonMobilePhone=buff.PersonMobilePhone__c;
                if(buff.PersonOtherCity__c!=null) newAccount.PersonOtherCity=buff.PersonOtherCity__c;
                if(buff.PersonOtherStreet__c!=null) newAccount.PersonOtherStreet=buff.PersonOtherStreet__c;
                if(buff.PersonMailingStreet__c!=null) newAccount.PersonMailingStreet=buff.PersonMailingStreet__c;
                if(buff.PersonOtherState__c!=null) newAccount.PersonOtherState=buff.PersonOtherState__c;
                if(buff.PersonMailingState__c!=null) newAccount.PersonMailingState=buff.PersonMailingState__c;
                
                
                if(buff.StorageLocationTEL__c!=null) newCase.StorageLocationTEL__c=buff.StorageLocationTEL__c;
                if(buff.LocationAddress_memo__c!=null) newCase.LocationAddress_memo__c=buff.LocationAddress_memo__c;
                if(buff.StorageLocationPerson__c!=null) newCase.StorageLocationPerson__c=buff.StorageLocationPerson__c;
                if(buff.StorageLocation__c!=null) newCase.StorageLocation__c=buff.StorageLocation__c;
                
                if(buff.PersonOtherPostalCode__c!=null) newAccount.PersonOtherPostalCode=buff.PersonOtherPostalCode__c;
                if(buff.PersonMailingPostalCode__c!=null) newAccount.PersonMailingPostalCode=buff.PersonMailingPostalCode__c;
                
                if(buff.PickUpDate__c!=null) newCase.PickUpDate__c=buff.PickUpDate__c;
                if(buff.AfterDocuments_CompleteCheck__c!=null) newCase.AfterDocuments_CompleteCheck__c=buff.AfterDocuments_CompleteCheck__c;
                
                //if(buff.CreatedDate!=null)newWorkRecord.CreatedDate__c=buff.Oppotunity__r.CreatedDate;
                
                if(buff.ReceptionDateTime__c!=null) newCase.ReceptionDateTime__c=buff.ReceptionDateTime__c;
                if(buff.ListingEndsDate__c!=null) newCase.ListingEndsDate__c=buff.ListingEndsDate__c;
                if(buff.DocumentCompleteCheck__c!=null) {
                    newCase.DocumentCompleteCheck__c=buff.DocumentCompleteCheck__c;
                    newPurchaseOpportunity.DocumentOK__c  = True ;
                    
                }
                if(buff.TransferDate__c!=null) {
                    newCase.TransferDate__c=buff.TransferDate__c;
                    newPurchaseOpportunity.TransferDate__c  =buff.TransferDate__c;
                }  
                if(buff.CompletionDate__c!=null)newPurchaseOpportunity.CompletionDate__c=buff.CompletionDate__c; 
                if(buff.ContractCompletedDate__c!=null) newCase.ContractCompletedDate__c=buff.ContractCompletedDate__c;
                
                if(buff.CancelDate__c!=null) {
                    newCase.CancellationDate__c=buff.CancelDate__c;
                    newPurchaseOpportunity.CancelDate__c  =buff.CancelDate__c;
                }  
                //if(buff.CancelReason__c!=null)newPurchaseOpportunity.CancelReason__c=buff.CancelReason__c;
                
                //if(buff.CancellationPenalty__c!=null) newCase.CancellationPenalty__c=buff.CancellationPenalty__c;
                if(buff.Cancellation_reason__c!=null) newCase.Cancellation_reason__c=buff.Cancellation_reason__c;
                if(buff.CancellationAfterSold__c!=null) newCase.CancellationAfterSold__c=buff.CancellationAfterSold__c;
                if(buff.CancellationAfterPurchased__c!=null) newCase.CancellationAfterPurchased__c=buff.CancellationAfterPurchased__c;
                
                if(buff.Desired_amount_hs__c!=null) newCase.Desired_amount_hs__c=buff.Desired_amount_hs__c;
                
                //if(buff.UserCode__c!=null) newCase.UserCode__c=buff.UserCode__c;
                
                if(ccstrList.contains(buff.Id_Case__c)) newCcs.add(newCase);
                if(postrList.contains(buff.Id_Oppotunity__c)) newPos.add(newPurchaseOpportunity);
                if(castrList.contains(buff.Id_CallA__c)) newCas.add(newCallCenterA_Opportunity);
                if(accstrList.contains(buff.Id_Account__c)) {
        newAccs.add(newAccount); 
        accstrList.remove(accstrList.indexOf(buff.Id_Account__c));
        }
            }

            
            if(newPos.size()>0){
                system.debug(newPos);
                system.debug(postrList);
                
                update newPos;
            }
            if(newCas.size()>0){
                system.debug(newCas);
                system.debug(castrList);
                
                update newCas;
            } 
            if(newAccs.size()>0) {
                system.debug(newAccs);
                system.debug(accstrList);
                update newAccs;
            }
            if(newCcs.size()>0) {
                system.debug(newCcs);
                system.debug(ccstrList);
                
                update newCcs;
            }
           // upsert exToTrueList Id_Case__c;
            
        }
        
    }
}