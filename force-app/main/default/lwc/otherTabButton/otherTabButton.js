import { LightningElement, track, api} from 'lwc';
import IsEnableRecodeType from '@salesforce/apex/AccountAssessmentDao.IsEnableRecodeType';
import userId from '@salesforce/user/Id';
import getUserProfileID from '@salesforce/apex/UserDao.getUserProfileID';

export default class OtherTabButton extends LightningElement {
    @api propButtonLabel;
    @api propUrl;
    @api propUseID;
    @api propAllowProfileIds;
    @api recordId;
    @track isShowButton = false; 

    connectedCallback() {

        // レコードタイプが「オークション」かどうかチェック
        IsEnableRecodeType({assId: this.recordId}).then(result => {
            if (result == false){
                console.log("Not Auction Recode");
                // レコードタイプで許可されていない場合はプロファイルチェックに関わらず非表示
                return;
            }
            
            // プロファイルのチェック
            if (this.propAllowProfileIds == "" ){
                console.log("Allow All Profile");
                // プロファイル制限がない場合表示
                this.isShowButton = true;
            }else{
                // ログインユーザのプロファイルを取得
                getUserProfileID({userId: userId}).then(result => {
                    console.log(result);
                    if (this.propAllowProfileIds.indexOf(result) != -1){
                        console.log("Allow Profile");
                        // 有効リストに含まれる場合表示
                        this.isShowButton = true;
                    }
                }).catch(error => {
                    console.log(error);
                });
            }
        }).catch(error => {
            console.log(error);
        });
    }

    onClick(){
        // 指定URLを別タブで開く
        var url = this.propUrl;
        if (this.propUseID){
            url += "?id=" + this.recordId;
        }
        window.open(url);
    }
}