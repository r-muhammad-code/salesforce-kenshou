/**
 * オークション情報 ヘルパークラス
 */
public without sharing class AuctionInfoHelper {

    // コンストラクタ
    public AuctionInfoHelper() {

    }

    /**
     * ファイル名の番号を取得する
     */
    public String getImgFileNameNumber(String fileName) {
        String fileNumber = '';
        fileNumber = fileName.right(1);
        return fileNumber;
    }

}