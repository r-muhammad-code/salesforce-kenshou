@IsTest
public class CreateOrderingApiCallerTest {

    // 正常系モック
    private class SuccessMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"result":"ok"}'); // 成功時のレスポンス
            res.setStatusCode(200);
            return res;
        }
    }

    // 異常系モック
    private class ErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"error":{"code":"400","message":"Bad Request"}}');
            res.setStatusCode(400);
            return res;
        }
    }

    @IsTest
    static void testCallOrderingApi_success() {
        // モックを登録
        Test.setMock(HttpCalloutMock.class, new SuccessMock());

        // 入力データ作成
        List<CreateOrderingApiCaller.RequestWrapper> inputs = new List<CreateOrderingApiCaller.RequestWrapper>();
        CreateOrderingApiCaller.RequestWrapper req = new CreateOrderingApiCaller.RequestWrapper();
        req.kari_dp_num = '8000001';
        req.hd_hacchuukbn = '1';
        req.jigyoushocode = '001';
        req.od_date = '2025/06/30';
        req.hd_nyuuka_yoteidate = '2025/06/30';
        req.hd_sryoteidate = '2025/06/30';
        req.tantoucode = 'H0001199';
        req.sr_code = '212366';
        req.sr_cname = 'テスト';
        req.sh_code = '212366';
        req.shtyou_hasikbn = '0';
        req.sh_yoteidate = '2025/06/30';
        req.sh_methcode = '2010';
        req.hd_yardcode = '1000';
        req.ms_gnum = '1';
        req.ms_htkbn = '1';
        req.saimukamokukbn = '3100';
        req.ms_soukocode = '1000';
        req.shouhin_code = '10010009';
        req.shouhin_hendounum = '0';
        req.kikaku = '111111111';
        req.tz_kanrisuukbn = '0';
        req.zeiritsukbn = '0';
        req.msunitprice_s_unitkbn = '0';
        req.msunit_insuu = '1';
        req.msunit_suu = '1';
        req.msunitprice_s_unitcode = '09';
        req.ms_insuu = '1';
        req.ms_shisansuu = '1';
        req.kari_unit_kbn = '0';
        req.sr_unitprice = '0';
        req.srgaku = '0';
        req.srtax = '0';
        req.ms_nyuukayoteidate = '2025/06/30';
        req.ms_sr_yoteidate = '2025/06/30';
        req.uw_gnum = '1';
        req.lot_num = '8000001';
        req.uw_insuu = '1';
        req.uw_shisansuu = '1';
        req.lot_bikou1 = '111111111';
        req.eigyoutantou = 'H0001199';
        req.uketantou = 'H0001199';
        req.sj_nenshiki = '2013';
        req.shonendo_month = '09';
        req.shorikbn = '8';
        req.srj_joutai = '2';
        req.shorui_senyoteidate = '2025/07/31';
        req.srj_ankenkbn = '1';
        req.eigyou_houjinkbn = '1';
        req.chk_jzkp = '2';
        req.chk_shokanfolder = '//10.100.16.101/guest-share/OBIC/2025/4/17/8000001';
        req.sj_nyuukapfnum_chiiki = '大阪';
        req.sj_nyuukapfnum_suuji = '500わ1111';
        inputs.add(req);

        Test.startTest();
        List<CreateOrderingApiCaller.ApiResultWrapper> results = CreateOrderingApiCaller.callOrderingApi(inputs);
        Test.stopTest();

        System.assertEquals(1, results.size(), '結果が1件返るはず');
        System.assertEquals(true, results[0].success, '成功フラグがtrueのはず');
        System.assertEquals(200, results[0].statusCode, 'HTTPステータスが200のはず');
        System.assertEquals(null, results[0].errorMessage, 'エラーメッセージはnullのはず');
    }

    @IsTest
    static void testCallOrderingApi_error() {
        // モックを登録
        Test.setMock(HttpCalloutMock.class, new ErrorMock());

        // 入力データ作成
        List<CreateOrderingApiCaller.RequestWrapper> inputs = new List<CreateOrderingApiCaller.RequestWrapper>();
        CreateOrderingApiCaller.RequestWrapper req = new CreateOrderingApiCaller.RequestWrapper();
        req.kari_dp_num = '8000002';
        req.hd_hacchuukbn = '1';
        req.jigyoushocode = '';
        req.od_date = '2025/07/30';
        req.hd_nyuuka_yoteidate = '2025/07/30';
        req.hd_sryoteidate = '2025/06/30';
        req.tantoucode = 'H0001199';
        req.sr_code = '212300';
        req.sr_cname = 'テスト';
        req.sh_code = '212300';
        req.shtyou_hasikbn = '0';
        req.sh_yoteidate = '2025/06/30';
        req.sh_methcode = '2010';
        req.hd_yardcode = '1000';
        req.ms_gnum = '1';
        req.ms_htkbn = '1';
        req.saimukamokukbn = '3100';
        req.ms_soukocode = '1000';
        req.shouhin_code = '10010009';
        req.shouhin_hendounum = '0';
        req.kikaku = '222222222';
        req.tz_kanrisuukbn = '0';
        req.zeiritsukbn = '0';
        req.msunitprice_s_unitkbn = '0';
        req.msunit_insuu = '1';
        req.msunit_suu = '1';
        req.msunitprice_s_unitcode = '09';
        req.ms_insuu = '1';
        req.ms_shisansuu = '1';
        req.kari_unit_kbn = '0';
        req.sr_unitprice = '0';
        req.srgaku = '0';
        req.srtax = '0';
        req.ms_nyuukayoteidate = '2025/07/30';
        req.ms_sr_yoteidate = '2025/07/30';
        req.uw_gnum = '1';
        req.lot_num = '8000002';
        req.uw_insuu = '1';
        req.uw_shisansuu = '1';
        req.lot_bikou1 = '222222222';
        req.eigyoutantou = 'H0001199';
        req.uketantou = 'H0001199';
        req.sj_nenshiki = '2014';
        req.shonendo_month = '07';
        req.shorikbn = '8';
        req.srj_joutai = '2';
        req.shorui_senyoteidate = '2025/08/31';
        req.srj_ankenkbn = '1';
        req.eigyou_houjinkbn = '1';
        req.chk_jzkp = '2';
        req.chk_shokanfolder = '//10.100.16.101/guest-share/OBIC/2025/8/17/8000002';
        req.sj_nyuukapfnum_chiiki = 'なにわ';
        req.sj_nyuukapfnum_suuji = '300は2222';
        inputs.add(req);

        Test.startTest();
        List<CreateOrderingApiCaller.ApiResultWrapper> results = CreateOrderingApiCaller.callOrderingApi(inputs);
        Test.stopTest();

        System.assertEquals(1, results.size(), '結果が1件返るはず');
        System.assertEquals(false, results[0].success, '成功フラグがfalseのはず');
        System.assertEquals(400, results[0].statusCode, 'HTTPステータスが400のはず');
        System.assertEquals('Bad Request', results[0].errorMessage, 'エラーメッセージが返るはず');
    }
}