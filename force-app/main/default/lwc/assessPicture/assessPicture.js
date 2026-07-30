import { LightningElement, track, api } from 'lwc';
import LoadRecord from '@salesforce/apex/AssessPictureController.LoadRecord';
import assessPicture from '@salesforce/resourceUrl/assessPicture';

export default class AssessPicture extends LightningElement {
    @api objectName;
    @api imageColumnList;
    @api columnNameList;
    @api recordId;
    @track resultList = [];
    @track errorMessage = '';
    noImage = `${assessPicture}`;

    connectedCallback() {
        LoadRecord({
            objectName: this.objectName,
            imageColumnList: this.imageColumnList,
            recordId: this.recordId
        })
        .then(result => {
            console.log('Apexからの結果:', result);

            // 画像URL項目リストをカンマで分割し、配列化
            const imageColumnLists = this.imageColumnList.split(',');
            // 画像項目表示名リストをカンマで分割し、配列化
            const columnNameLists = this.columnNameList.split(',');

            //画像URL項目リストのlengthと画像項目表示名リストのlengthが一致しない場合はエラーし終了
            if(imageColumnLists.length != columnNameLists.length){
                 this.errorMessage = '画像URL項目リストと画像項目表示名リストの数が一致していません。\n LWCのプロパティを確認してください。';
                 return;
            }

            // 画像表示用リストを初期化
            this.resultList = []; 

            // 画像URL項目リストの数だけループ
            imageColumnLists.forEach((column, index) => {
                const url = result[column] || this.noImage;
                const resultItem = {
                    DispName: columnNameLists[index],
                    Url: url,
                    ImageName: 'Image_' + column,
                };
                this.resultList.push(resultItem);
            });
            console.log('画像表示リスト:', JSON.parse(JSON.stringify(this.resultList)));
        })
        .catch(error => {
            this.errorMessage = '例外エラー発生：\n'+(error.body.message || 'An unexpected error occurred.');
            console.error(this.errorMessage);
        });
    }

    onClickImage(e) {
        const imageUrl = e.target.dataset.url;
        window.open(imageUrl, '_blank');
    }
}