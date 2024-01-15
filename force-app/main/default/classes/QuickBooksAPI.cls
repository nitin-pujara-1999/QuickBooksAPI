public class QuickBooksAPI {
    // @AuraEnabled(cacheable = true)
    // public static String createExpense(String reqBody, String attachmentBody, String attachmentName, String attachmentType) {
    //     // Create the expense
    //     Http http = new Http();
    //     HttpRequest request = new HttpRequest();
    //     request.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/purchase?minorversion=40');
    //     request.setMethod('POST');
    //     request.setHeader('Content-Type', 'application/json');
    //     request.setHeader('Accept', 'application/json');
    //     request.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..gPrlQnWkgTtcBj8GZLPKnQ.UX0XvFN4ss419ihabgrfhQq3t4ZWTEs6ZJ6sozV1uwiqKYL2EyyWci4iDGmrE6dh8gGoMVdXWOh80PUOgaIV8Cvoo8X86KEWIsKCsIGla8DFV-Q6G0kCeO8Rc7xuaYFogTRjFUdmrKz4LM2nea0-mQ0Hr2w9WajzTGxcFguydNa3GuU9SeQGyjlzrsQsarlChKstCG6gFtJgemo47U6rVm6UaS2rlqC9B3tWggK71HOpdT5dhEUb4TQWVwvduuSgTz1itbNTfPB_VYjGPSdxBAIrybtGurXZRlGqSKqVjOVhff4Ok4fs9-FJVwnM_Fm-fLoPpwBF7ibd3w2U6CB827gnzMpvNBaxtZ0NoNKut45UmzZ-NxaGlT9QQZsXqIqIpwtSIF1ltr9HQYP-JSrKAF-FVvk7NvrE0H4iq4jgNi9R8-e2FmdLLmBFh8tWbl7wgSkULHplgir29eLk6bdRbNVheQdOyFlKa6sntqixDYcXWBtL5GcaqixTSn1_ipXhKkWJOSLAf331m9tH-UlIoDeoMQkhGYsaL_bSa0V3PNLioGaYXtGqdMB2QB1C1QDnpG_1sFGqXo7oGX4FsYQtT1C8FosJyp3Z3eb1nQ_Wt48y2p8kcocrzqc3WDTP-YksHdK8_PHbLF-K1KeuWW4J1ut0wc5W7YwpXzCoGvEl5yBMkzKdg3q5leYE8pKffLw24iU1sYZXcrhtaRYeZ8wNYYJi1-MYxI8yqqp9yFLj5TyS-uL8Y8DDGAe8qR5GElasIHdTPCE774I7WkSa5bTKStZrwBfPNaVM0sziEhDTOgCmKov9f3iK1ibdQVfCQkKuT9dIOgsLgApEOb55PCLPbfOtYVc7nap-k1HelWXRAcWiBTNUJpuYikzJ38LVyjikhWs9OYi7llcKJdlPVWZABw.N0P1CtVnhNMCQW21mJJTAw');
    //     String requestBody = reqBody;
    //     request.setBody(requestBody);
    //     HttpResponse response = http.send(request);
        
    //     // Parse the response to get the created expense ID
    //     Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    //     Map<String, Object> purchase = (Map<String, Object>) responseBody.get('Purchase');
    //     System.debug('Expense Details: ' + purchase);
    //     String expenseId = (String) purchase.get('Id');
    //     System.debug('Expense ID: ' + expenseId);


    //     if(response.getStatusCode() == 200 && expenseId != null){
    //         addAttachment(expenseId,attachmentBody, attachmentName, attachmentType);
    //         system.debug('addAttachment called');
    //     }
    //     System.debug('Attachment Response Body' + response.getBody());

    //     return response.getBody();
    // } 

    @AuraEnabled(cacheable = true)
public static String createExpense(String reqBody, List<Map<String, String>> files) {
    // Create the expense
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/purchase?minorversion=40');
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('Accept', 'application/json');
    request.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..gPrlQnWkgTtcBj8GZLPKnQ.UX0XvFN4ss419ihabgrfhQq3t4ZWTEs6ZJ6sozV1uwiqKYL2EyyWci4iDGmrE6dh8gGoMVdXWOh80PUOgaIV8Cvoo8X86KEWIsKCsIGla8DFV-Q6G0kCeO8Rc7xuaYFogTRjFUdmrKz4LM2nea0-mQ0Hr2w9WajzTGxcFguydNa3GuU9SeQGyjlzrsQsarlChKstCG6gFtJgemo47U6rVm6UaS2rlqC9B3tWggK71HOpdT5dhEUb4TQWVwvduuSgTz1itbNTfPB_VYjGPSdxBAIrybtGurXZRlGqSKqVjOVhff4Ok4fs9-FJVwnM_Fm-fLoPpwBF7ibd3w2U6CB827gnzMpvNBaxtZ0NoNKut45UmzZ-NxaGlT9QQZsXqIqIpwtSIF1ltr9HQYP-JSrKAF-FVvk7NvrE0H4iq4jgNi9R8-e2FmdLLmBFh8tWbl7wgSkULHplgir29eLk6bdRbNVheQdOyFlKa6sntqixDYcXWBtL5GcaqixTSn1_ipXhKkWJOSLAf331m9tH-UlIoDeoMQkhGYsaL_bSa0V3PNLioGaYXtGqdMB2QB1C1QDnpG_1sFGqXo7oGX4FsYQtT1C8FosJyp3Z3eb1nQ_Wt48y2p8kcocrzqc3WDTP-YksHdK8_PHbLF-K1KeuWW4J1ut0wc5W7YwpXzCoGvEl5yBMkzKdg3q5leYE8pKffLw24iU1sYZXcrhtaRYeZ8wNYYJi1-MYxI8yqqp9yFLj5TyS-uL8Y8DDGAe8qR5GElasIHdTPCE774I7WkSa5bTKStZrwBfPNaVM0sziEhDTOgCmKov9f3iK1ibdQVfCQkKuT9dIOgsLgApEOb55PCLPbfOtYVc7nap-k1HelWXRAcWiBTNUJpuYikzJ38LVyjikhWs9OYi7llcKJdlPVWZABw.N0P1CtVnhNMCQW21mJJTAw');
    String requestBody = reqBody;
    request.setBody(requestBody);
    HttpResponse response = http.send(request);
    
    // Parse the response to get the created expense ID
    Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    Map<String, Object> purchase = (Map<String, Object>) responseBody.get('Purchase');
    System.debug('Expense Details: ' + purchase);
    String expenseId = (String) purchase.get('Id');
    System.debug('Expense ID: ' + expenseId);

    if(response.getStatusCode() == 200 && expenseId != null){
        String filesJson = JSON.serialize(files);
        addAttachment(expenseId, filesJson);
        system.debug('addAttachment called');
    }
    
    System.debug('Attachment Response Body' + response.getBody());

    return response.getBody();
}


        // @AuraEnabled(cacheable = true)
        // public static String createExpense(String reqBody, List<String> attachments, String attachmentName, String attachmentType) {
        //     // Create the expense
        //     Http http = new Http();
        //     HttpRequest request = new HttpRequest();
        //     request.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/purchase?minorversion=40');
        //     request.setMethod('POST');
        //     request.setHeader('Content-Type', 'application/json');
        //     request.setHeader('Accept', 'application/json');
        //     request.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..AnxpF9oXbQSlCyr67mUSPw.vlxZN9vrgZm9bcsrAlPBQ6g44dUqCOQezyRlB1NqtOsRy3yODE6Mooer07gXPr0Ihm4WsRKAS6ZQVPn0Sd2VVV7UJWYrmwP2NNvW-YDKmnKEaYXOqY15689-TlYwrZgGCFvrBm-UjWjiPm7r8Kv3Dpxq3talmY-Avivt1ufeXeZhmELNV8MjlDauL2bBNoDJheIdIv2BaHgXLY-s-5T-iAaAXCiNJo8NGD6inPHebyObzafR0I-wtx_lSKs3jgolWsFfxkrfhxnjVi2q2gipb6NNviXfr4msxN59kdloydYgq2_bFsxgmXlDqokXq8RdfqVoN_H5Em52vwl1Vi93c-lSTunWqAveC8rBqvyzfk2NwdvaxWPnOut9tNhbDtqFl4LRPjnpPRjFgsVg7N_q10HNY3XREcqnBYZ1k6L_PFSGnvUeWr2iWP1oRU2m71kY8dtF-3oxDD2MRPijRgpevryAK3xqPOJ_JLX6xt5mtbN1vXdSm1-1GNbH0o91dU7wRBHpSeu4-jOOPq6X6IIeqdZBHsWgw8reucyk4qdP00mfSuQpG2GUCVS-Q67WaDWDcKXJNdx7Eh1P2-FEXKJenbnrTDZUl2c1LmRHkttVdEFs3qjV2oGPXO_l8LrX0HMaFmqtwZQPTYC4xYBmCk27g0Ar-DM1ljPGy83-mZ8su69U1bzoxrDOb25mBokHyupYbl1J8_cty-iw3Lm2JG-5mQAey2KEWXuIaW6vPysbQmBCgPKyJ8eiMlfUBVCSyzfPr-XG-7haShiMC8M2PXji4fZwXR3Y3_QjrUOrIZNc2sTrhoVnHkSRWHRnismeD33AWVJN23f3UVM8-4bSyAFTjfURu-ThB_W8RM40FN1gS0UZL8tUmVAnrPjJt_0wNcE2lNb8NN2ju1UnJA0oc6u9Sw.T6j7quVH8gRErxpT8VI9TQ');
        //     String requestBody = reqBody;
        //     request.setBody(requestBody);
        //     HttpResponse response = http.send(request);

        // // Parse the response to get the created expense ID
        // Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        // Map<String, Object> purchase = (Map<String, Object>) responseBody.get('Purchase');
        // System.debug('Expense Details: ' + purchase);
        // String expenseId = (String) purchase.get('Id');
        // System.debug('Expense ID: ' + expenseId);
    
        //     if(response.getStatusCode() == 200 && expenseId != null){
        //         for (String attachmentBody : attachments) {
        //             addAttachment(expenseId, attachmentBody, attachmentName, attachmentType);
        //         }
        //         system.debug('addAttachment called');
        //     }
        //     System.debug('Attachment Response Body' + response.getBody());
    
        //     return response.getBody();
        // }
    
    
    // @AuraEnabled(cacheable = true)
    // public static String createExpense(String reqBody, List<String> attachmentBodies, List<String> attachmentNames, List<String> attachmentTypes) {
    //     // Create the expense
    //     Http http = new Http();
    //     HttpRequest request = new HttpRequest();
    //     request.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/purchase?minorversion=40');
    //     request.setMethod('POST');
    //     request.setHeader('Content-Type', 'application/json');
    //     request.setHeader('Accept', 'application/json');
    //     request.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..XugAb3MrJBBHSwsXH60_yA.gKlyX-GBeouZQmBQGq7YAwotR05KSfPaYLHoK4qzeTNkC9gm0AcLgpomvGLKBlS4JBwKAburnpnFz1HKFH971CyOWZ0XxF9wFAzlsv7ZeAZD0VD-P-Vt1RcayPKH3SMmfO1OA1zLL5bcIbFd47sflxT_3EQejUXz5FL_4NR79Uz3ZJP4XAP2byA6ZyHbpH7ra6dyQjWirxv-c-N6Z9cxgmTZNfG6hJzphmGZkVeWLbuddmFzaHh0CqppaAYC5oIKlF-5I4O_iIZ4Qma2uAndkcCLpYoqUPjIXGWYzWoaeVbV37j9RXy2yvScbHKwng6y5ZnB70Pzc03BssD1obqGgvUjTfNc0U5PtsZzDLA5YNIjCANQyNWnBqHtx1POGX5Mr_6Jgei-KE2Gb5VqJ-xhjBfFrg1edSvj62isD1grYIVJaaDoNjxQw-eWUeNFVEKX1lffwBYCuUE6glq9zA9exa3m_tp5VxustM9FS6tR5TfgZdG9xW0pQkdQyy3dFoB8biSA8czTzn3OXl93iLmik2WeZLQqBTVVOxx527rm7mOTjNKBMqwcl-szxCAMb5ZTlodQj3u-PLYtFxzJEZiGJ-pPJUjKDye61VXDHex63bP_AtFMTuUT5wgrCCKNgBl-DgQE1Aee02_axSAb5COlGBOhROigfbDkSmNvuVcClJFET_qp37Fa2DdMOWSJ95tKB3xpUK0A20oH5sps4Ivjs6vDSg4Z3wuSD0NYY0NYVBLXWTZmTiJwRcLRByEZjwXR7tODpajwjwCs_h4epu1AxS9C2gIRGWILwjSImbXBwCC7qrYWk2WtMOQ4XgwgyheW5N7rGPU1n8NsIU39rLDQt52B858BPGLyi7oNS4YmqdLfc72ZkZx_Nfb_UWVpvjL4m8TumBmhcJWK2pxZJyWOMw.s2uq6vsHcVMJioA9LbyBlA');
    //     String requestBody = reqBody;
    //     request.setBody(requestBody);
    //     HttpResponse response = http.send(request);
        
    //     // Parse the response to get the created expense ID
    //     Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    //     Map<String, Object> purchase = (Map<String, Object>) responseBody.get('Purchase');
    //     System.debug('Expense Details: ' + purchase);
    //     String expenseId = (String) purchase.get('Id');
    //     System.debug('Expense ID: ' + expenseId);
    
    //     if(response.getStatusCode() == 200 && expenseId != null){
    //         addAttachment(expenseId, attachmentBodies, attachmentNames, attachmentTypes);
    //         system.debug('addAttachment called');
    //     }
    //     System.debug('Attachment Response Body' + response.getBody());
    
    //     return response.getBody();
    // }
    

        // @future(callout=true)
        // public static void addAttachment(String expenseId, String attachmentBody, String attachmentName, String attachmentType) {
        //     System.debug('Starting addAttachment method');

        //     if (expenseId == null) {
        //         System.debug('Error: expenseId is null or empty');
        //         return;
        //     }
        //     // Define the boundary
        //     String boundary = 'YOjcLaTlykb6OxfYJx4O07j1MweeMFem';
        //     String delimiter = '\r\n--' + boundary + '\r\n';
        //     String close_delim = '\r\n--' + boundary + '--';
        //     String attachableRef = '{"AttachableRef": [{"EntityRef": {"type": "Purchase", "value": "' + expenseId + '"}}], "FileName": "' + attachmentName + '", "ContentType": "' + attachmentType + '"}';
        //     System.debug('attachableRef: ' + attachableRef);
        
        //     // Convert the attachment body to binary data
        //     Blob pdf = EncodingUtil.base64Decode(attachmentBody);
        //     System.debug('pdf Blob size: ' + pdf.size());
        
        //     // Build form data body chunks
        //     String metadataBodyHeader = delimiter 
        //         + 'Content-Disposition: form-data; name="file_metadata_01"; filename="attachment.json"\r\n'
        //         + 'Content-Type: application/json\r\r\n';
        //     String fileBodyHeader = delimiter 
        //         + 'Content-Disposition: form-data; name="file1"; filename="' + attachmentName + '"\r\n'
        //         + 'Content-Type: application/octet-stream\r\n'+ '\r\n';
        
        //     String bodyEnd = close_delim;
        
        //     // Convert form data body chunks to binary data
        //     Blob bodyStartBlob = Blob.valueOf(metadataBodyHeader + attachableRef + fileBodyHeader);
        //     Blob bodyEndBlob = Blob.valueOf(bodyEnd);
        
        //     // To build 1 body including binary data we need to convert all chunks to text so we can concatenate the binary chunks
        //     String combinedDataAsHex = EncodingUtil.convertToHex(bodyStartBlob) + EncodingUtil.convertToHex(pdf) + EncodingUtil.convertToHex(bodyEndBlob);
        
        //     // Convert back to binary
        //     Blob BodyBlob = EncodingUtil.convertFromHex(combinedDataAsHex);
        //     System.debug('BodyBlob size: ' + BodyBlob.size());
        
        //     // Build request using setBodyAsBlob
        //     HttpRequest req = new HttpRequest();
        //     req.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/upload');
        //     req.setMethod('POST');
        //     req.setHeader('Content-Type', 'multipart/form-data; boundary="' + boundary + '"'); //do not forget boundary
        //     system.debug('req.header.contenttype: ' + req.getHeader('Content-Type'));
        //     req.setHeader('Content-Length', String.valueOf(BodyBlob.size()));
        //     system.debug('req.header.contentlength: ' + req.getHeader('Content-Length'));
        //     req.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..E2m7PpDRyr8DegdLze0bXw.DEQLM7fqveq9wIqZ1bkdndBCC_8skOqrtKryBCpof6b7ItWzLFC6r4A-EO-nSnH6vT7yZzZRnQVww4ZiHf_NUapDeBVxaz-HwOmNmNakCfZhh4uSSb3Rp6qnmMN5d8Td7MtuNrvCv-YKAPKe739XfYaH3yzVvYkfkHQ69mg9LAsPlup9y9AmRvMWAjhN-h13t04_7ChUV3QBEDcelaAZD7fgzi0mq0GrYSrqgbB7Fvi6x3NYGwjeraEpphbdCb_qxoEj_NvXCUvwIFuXFhs5553rHPsjgQ3vHAqSnZOGVv3KXKfL9bjU5gj3wnr2jkrDaJ03jeswGUdcd1slErtgCIh-Zvh2WsPK8ylZq-5AXWITTeoKGWLfY4GoKNSmcdMWNIZR2uD3GiqH3-PNvy4lM6IG3E6N8aqNEBJ3-glpAuai-Oks9fo_xNwnOOw0eTtQsXZxII64bvNanMezhT6k2BBCYUTt_pL-acaK8RYmBL_uBdjte6dp2zsLrl_hR_A792RV3Bu25u8IxqgIKoD5nH-qQMX015SBPRsjzrj7_8fCPzHIgrF1eajSSJ_ZnSk2oczIj7fCn4noSKpReSk5lN0fMAHUsh7ys_N0aPKVKeKqhAJGrUaJ6iBmmh3QwPHpdBbOvY8q5j8iRDq_4AcFPjfTNWAvHAjn7HrWHpVgOUpwOjcATvIiKmp4KifiI18LqaZwXOE4RGKCW-6o1TvTKx3WKTIsMtd9pkMUPfiypTfeBPvuzhVx457bApAQGOfTZI1AERCTuxGlTb5wo9NtsohkBLW1arVz37-ci63C4-bHFBDqrogx9CuCHnV91yyHvjLy6UMfRjCjRgRpChyy8yfsrG_9zWmZ2sgxoU3H4hz56G1qbM-Ap9b2MmFDlpBbURf5EchI-_25YfzDPbvuzw.-HYQ2wraREOBm4MNBUI3fw');
        //     req.setBodyAsBlob(BodyBlob);
        //     Http http = new Http();
        //     System.debug('Sending HTTP request');
        //     HTTPResponse res = http.send(req);
        //     System.debug('HTTP response status: ' + res.getStatus());
        //     System.debug('HTTP response body: ' + res.getBody());
        // }
        

        // @future(callout=true)
        // public static void addAttachment( String expenseId , String attachmentBody, String attachmentName, String attachmentType ){

        //         // Create the attachment
        //         String boundary = 'YOjcLaTlykb6OxfYJx4O07j1MweeMFem';
        //         String attachableRef = '{"AttachableRef": [{"EntityRef": {"type": "Purchase", "value": "' + expenseId + '"}}], "FileName": "' + attachmentName + '", "ContentType": "' + attachmentType + '"}';
                
        //         String body = '--' + boundary + '\r\n'
        //         + 'Content-Disposition: form-data; name="file_metadata_01"; filename="attachment.json"\r\n'
        //         + 'Content-Type: application/json; charset=UTF-8\r\n'
        //         + 'Content-Transfer-Encoding: 8bit\r\n\r\n'
        //         + attachableRef + '\r\n';
                
        //         body += '--' + boundary + '\r\n'
        //         + 'Content-Disposition: form-data; name="file_content_01"; filename="' + attachmentName + '"\r\n'
        //         + 'Content-Type: ' + attachmentType + '\r\n'
        //         + 'Content-Transfer-Encoding: base64\r\n\r\n'
        //         + attachmentBody + '\r\n';
                
        //         body += '--' + boundary + '--\r\n';
                
        //         HttpRequest attachmentRequest = new HttpRequest();
        //         attachmentRequest.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/upload');
        //         attachmentRequest.setMethod('POST');
        //         attachmentRequest.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
        //         system.debug('req.header.contenttype: ' + attachmentRequest.getHeader('Content-Type'));
        //         attachmentRequest.setHeader('Accept', 'application/json');
        //         attachmentRequest.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..jLHPiPwVHh-L99WuLRVNmA.yO4ala0hjbKElt5t2GOIDExvrL4VTZffGl7vEmAbbhJ6dxtSXiM2iSXNPKN-dMFVUG3gblhERxyu0wf-5kdSdKIh8xoM8ROPrLd4y9rArte09489bnnf5YzM13fa6L_jpEJMwwXzjQL5e1Aa3PccYYxReVUP5PA50SaR6Ss6hjPfxN_qjKEJuZP5uSwDgR_D5kylcoj5hnvS33rm72gOudd5K2YuBqSHOksjxmsvV0uh3vfzNnhynwNAZ1K6dOv684kHIo64vJ0UF_JETU-GfEUzESq5oiogd-3a4pI1hTHD4m-RFkkV56OQGcUGWM0-WvmZRzXKeVMEIHyzqQTxStnZoa45wQqxmPm5DORcuAIjJq6TE-DioCL_Eo2V0XDfaYpBxgSDhPiQN3gDVLaK6TtiSsowzgGMZ6Sjed5Jzx2h1e728FaGZSLbjSdy3Lo7etgqzTGR4DqQde7PXmCimndYvn50H_iOms4Df3kQfDPbDVD1FVFNxW8fBoxEmhRamU4bWlqVXfRPc4_iCMJZ-1kA7jFQ_NB6WL6aW1qHzsWnQwNRwNeDV-daBooJ6cswKk_dXB8AZSY3lvH5WO9elkyJPl5bDI4WCFTEB2EetJ5ypS8ZyLdAY-8_ybeafbP817wKlm-AjGRsne06kOD9LguA7bBZI5O_9mC7d-vmVC-ZeUgbGWFa_Z-iY-Nbyjb0_s-wHx5OMuf2uuu9uROgDwsp3UhVx1wi7Cwn0c-TJHGPxpXQZ2_h84nrDogtEmXoKqQg8KTONCaHmRRJO0rOQiVrvelqkXUncmXbK68FZBXFhWY9qyzz_Mmr3fRZNGijg8qIG_5fRIL3156rUDH4jIipmeWe-L0MamANdgNaSa9W2Va4kYRy3JsTKoBtiQPRxrROSogF9C7rdchav0RErg.OINirirGcujpGKGDQRlDCA');
        //         attachmentRequest.setBody(body);
                
        //         Http http = new Http();
        //         System.debug('Sending HTTP request');

        //         HttpResponse attachmentResponse = http.send(attachmentRequest);

        //         System.debug('HTTP response status: ' + attachmentResponse.getStatus());

        //         System.debug('Attachment response Body' + attachmentResponse.getBody());

        // }

        @future(callout=true)
        public static void addAttachment(String expenseId, String filesJson) {
            List<Map<String, String>> files = (List<Map<String, String>>)JSON.deserialize(filesJson, List<Map<String, String>>.class);
            // Iterate over the files
            for (Map<String, String> file : files) {
                String attachmentBody = file.get('body');
                String attachmentName = file.get('name');
                String attachmentType = file.get('type');

        // Create the attachment
        String boundary = 'YOjcLaTlykb6OxfYJx4O07j1MweeMFem';
        String attachableRef = '{"AttachableRef": [{"EntityRef": {"type": "Purchase", "value": "' + expenseId + '"}}], "FileName": "' + attachmentName + '", "ContentType": "' + attachmentType + '"}';
        
        String body = '--' + boundary + '\r\n'
        + 'Content-Disposition: form-data; name="file_metadata_01"; filename="attachment.json"\r\n'
        + 'Content-Type: application/json; charset=UTF-8\r\n'
        + 'Content-Transfer-Encoding: 8bit\r\n\r\n'
        + attachableRef + '\r\n';
        
        body += '--' + boundary + '\r\n'
        + 'Content-Disposition: form-data; name="file_content_01"; filename="' + attachmentName + '"\r\n'
        + 'Content-Type: ' + attachmentType + '\r\n'
        + 'Content-Transfer-Encoding: base64\r\n\r\n'
        + attachmentBody + '\r\n';
        
        body += '--' + boundary + '--\r\n';
        
        HttpRequest attachmentRequest = new HttpRequest();
        attachmentRequest.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/upload');
        attachmentRequest.setMethod('POST');
        attachmentRequest.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
        system.debug('req.header.contenttype: ' + attachmentRequest.getHeader('Content-Type'));
        attachmentRequest.setHeader('Accept', 'application/json');
        attachmentRequest.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..gPrlQnWkgTtcBj8GZLPKnQ.UX0XvFN4ss419ihabgrfhQq3t4ZWTEs6ZJ6sozV1uwiqKYL2EyyWci4iDGmrE6dh8gGoMVdXWOh80PUOgaIV8Cvoo8X86KEWIsKCsIGla8DFV-Q6G0kCeO8Rc7xuaYFogTRjFUdmrKz4LM2nea0-mQ0Hr2w9WajzTGxcFguydNa3GuU9SeQGyjlzrsQsarlChKstCG6gFtJgemo47U6rVm6UaS2rlqC9B3tWggK71HOpdT5dhEUb4TQWVwvduuSgTz1itbNTfPB_VYjGPSdxBAIrybtGurXZRlGqSKqVjOVhff4Ok4fs9-FJVwnM_Fm-fLoPpwBF7ibd3w2U6CB827gnzMpvNBaxtZ0NoNKut45UmzZ-NxaGlT9QQZsXqIqIpwtSIF1ltr9HQYP-JSrKAF-FVvk7NvrE0H4iq4jgNi9R8-e2FmdLLmBFh8tWbl7wgSkULHplgir29eLk6bdRbNVheQdOyFlKa6sntqixDYcXWBtL5GcaqixTSn1_ipXhKkWJOSLAf331m9tH-UlIoDeoMQkhGYsaL_bSa0V3PNLioGaYXtGqdMB2QB1C1QDnpG_1sFGqXo7oGX4FsYQtT1C8FosJyp3Z3eb1nQ_Wt48y2p8kcocrzqc3WDTP-YksHdK8_PHbLF-K1KeuWW4J1ut0wc5W7YwpXzCoGvEl5yBMkzKdg3q5leYE8pKffLw24iU1sYZXcrhtaRYeZ8wNYYJi1-MYxI8yqqp9yFLj5TyS-uL8Y8DDGAe8qR5GElasIHdTPCE774I7WkSa5bTKStZrwBfPNaVM0sziEhDTOgCmKov9f3iK1ibdQVfCQkKuT9dIOgsLgApEOb55PCLPbfOtYVc7nap-k1HelWXRAcWiBTNUJpuYikzJ38LVyjikhWs9OYi7llcKJdlPVWZABw.N0P1CtVnhNMCQW21mJJTAw');
        attachmentRequest.setBody(body);
        
        Http http = new Http();
        System.debug('Sending HTTP request');

        HttpResponse attachmentResponse = http.send(attachmentRequest);

        System.debug('HTTP response status: ' + attachmentResponse.getStatus());

        System.debug('Attachment response Body' + attachmentResponse.getBody());
    }
}


//         @future(callout=true)
// public static void addAttachment(String expenseId, String attachmentBody, String attachmentName, String attachmentType) {
//     // Create the attachment
//     String boundary = 'YOjcLaTlykb6OxfYJx4O07j1MweeMFem';
//     String attachableRef = '{"AttachableRef": [{"EntityRef": {"type": "Purchase", "value": "' + expenseId + '"}}], "FileName": "' + attachmentName + '", "ContentType": "' + attachmentType + '"}';
    
//     String body = '--' + boundary + '\r\n'
//     + 'Content-Disposition: form-data; name="file_metadata_01"; filename="attachment.json"\r\n'
//     + 'Content-Type: application/json; charset=UTF-8\r\n'
//     + 'Content-Transfer-Encoding: 8bit\r\n\r\n'
//     + attachableRef + '\r\n';
    
//     body += '--' + boundary + '\r\n'
//     + 'Content-Disposition: form-data; name="file_content_01"; filename="' + attachmentName + '"\r\n'
//     + 'Content-Type: ' + attachmentType + '\r\n'
//     + 'Content-Transfer-Encoding: base64\r\n\r\n'
//     + attachmentBody + '\r\n';
    
//     body += '--' + boundary + '--\r\n';
    
//     HttpRequest attachmentRequest = new HttpRequest();
//     attachmentRequest.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/upload');
//     attachmentRequest.setMethod('POST');
//     attachmentRequest.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
//     system.debug('req.header.contenttype: ' + attachmentRequest.getHeader('Content-Type'));
//     attachmentRequest.setHeader('Accept', 'application/json');
//     attachmentRequest.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..gPrlQnWkgTtcBj8GZLPKnQ.UX0XvFN4ss419ihabgrfhQq3t4ZWTEs6ZJ6sozV1uwiqKYL2EyyWci4iDGmrE6dh8gGoMVdXWOh80PUOgaIV8Cvoo8X86KEWIsKCsIGla8DFV-Q6G0kCeO8Rc7xuaYFogTRjFUdmrKz4LM2nea0-mQ0Hr2w9WajzTGxcFguydNa3GuU9SeQGyjlzrsQsarlChKstCG6gFtJgemo47U6rVm6UaS2rlqC9B3tWggK71HOpdT5dhEUb4TQWVwvduuSgTz1itbNTfPB_VYjGPSdxBAIrybtGurXZRlGqSKqVjOVhff4Ok4fs9-FJVwnM_Fm-fLoPpwBF7ibd3w2U6CB827gnzMpvNBaxtZ0NoNKut45UmzZ-NxaGlT9QQZsXqIqIpwtSIF1ltr9HQYP-JSrKAF-FVvk7NvrE0H4iq4jgNi9R8-e2FmdLLmBFh8tWbl7wgSkULHplgir29eLk6bdRbNVheQdOyFlKa6sntqixDYcXWBtL5GcaqixTSn1_ipXhKkWJOSLAf331m9tH-UlIoDeoMQkhGYsaL_bSa0V3PNLioGaYXtGqdMB2QB1C1QDnpG_1sFGqXo7oGX4FsYQtT1C8FosJyp3Z3eb1nQ_Wt48y2p8kcocrzqc3WDTP-YksHdK8_PHbLF-K1KeuWW4J1ut0wc5W7YwpXzCoGvEl5yBMkzKdg3q5leYE8pKffLw24iU1sYZXcrhtaRYeZ8wNYYJi1-MYxI8yqqp9yFLj5TyS-uL8Y8DDGAe8qR5GElasIHdTPCE774I7WkSa5bTKStZrwBfPNaVM0sziEhDTOgCmKov9f3iK1ibdQVfCQkKuT9dIOgsLgApEOb55PCLPbfOtYVc7nap-k1HelWXRAcWiBTNUJpuYikzJ38LVyjikhWs9OYi7llcKJdlPVWZABw.N0P1CtVnhNMCQW21mJJTAw');
//     attachmentRequest.setBody(body);
    
//     Http http = new Http();
//     System.debug('Sending HTTP request');

//     HttpResponse attachmentResponse = http.send(attachmentRequest);

//     System.debug('HTTP response status: ' + attachmentResponse.getStatus());

//     System.debug('Attachment response Body' + attachmentResponse.getBody());
// }


//         @future(callout=true)
//         public static void addAttachment(String expenseId, List<String> attachmentBodies, List<String> attachmentNames, List<String> attachmentTypes) {
//             for (Integer i = 0; i < attachmentBodies.size(); i++) {
//                     String attachmentBody = attachmentBodies[i];
//                     String attachmentName = attachmentNames[i];
//                     String attachmentType = attachmentTypes[i];

//         // Create the attachment
//         String boundary = 'YOjcLaTlykb6OxfYJx4O07j1MweeMFem';
//         String attachableRef = '{"AttachableRef": [{"EntityRef": {"type": "Purchase", "value": "' + expenseId + '"}}], "FileName": "' + attachmentName + '", "ContentType": "' + attachmentType + '"}';
        
//         String body = '--' + boundary + '\r\n'
//         // + 'Content-Disposition: form-data; name="file_metadata_01"; filename="attachment.json"\r\n'
//         // + 'Content-Type: application/json; charset=UTF-8\r\n'
//         // + 'Content-Transfer-Encoding: 8bit\r\n\r\n'
//         // + attachableRef + '\r\n';
        
//         // body += '--' + boundary + '\r\n'
//         + 'Content-Disposition: form-data; name="file_content_01"; filename="' + attachmentName + '"\r\n'
//         + 'Content-Type: ' + attachmentType + '\r\n'
//         + 'Content-Transfer-Encoding: base64\r\n\r\n'
//         // + attachmentBody + '\r\n';
//         + attachableRef + '\r\n';

        
//         body += '--' + boundary + '--\r\n'
//         + 'Content-Disposition: form-data; name="file_content_02"; filename="' + attachmentName + '"\r\n'
//         + 'Content-Type: ' + attachmentType + '\r\n'
//         + 'Content-Transfer-Encoding: base64\r\n\r\n'
//         // + attachmentBody + '\r\n';
//         + attachableRef + '\r\n';
        
//         body += '--' + boundary + '\r\n';

//         HttpRequest attachmentRequest = new HttpRequest();
//         attachmentRequest.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/upload');
//         attachmentRequest.setMethod('POST');
//         attachmentRequest.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
//         system.debug('req.header.contenttype: ' + attachmentRequest.getHeader('Content-Type'));
//         attachmentRequest.setHeader('Accept', 'application/json');
//         attachmentRequest.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..XugAb3MrJBBHSwsXH60_yA.gKlyX-GBeouZQmBQGq7YAwotR05KSfPaYLHoK4qzeTNkC9gm0AcLgpomvGLKBlS4JBwKAburnpnFz1HKFH971CyOWZ0XxF9wFAzlsv7ZeAZD0VD-P-Vt1RcayPKH3SMmfO1OA1zLL5bcIbFd47sflxT_3EQejUXz5FL_4NR79Uz3ZJP4XAP2byA6ZyHbpH7ra6dyQjWirxv-c-N6Z9cxgmTZNfG6hJzphmGZkVeWLbuddmFzaHh0CqppaAYC5oIKlF-5I4O_iIZ4Qma2uAndkcCLpYoqUPjIXGWYzWoaeVbV37j9RXy2yvScbHKwng6y5ZnB70Pzc03BssD1obqGgvUjTfNc0U5PtsZzDLA5YNIjCANQyNWnBqHtx1POGX5Mr_6Jgei-KE2Gb5VqJ-xhjBfFrg1edSvj62isD1grYIVJaaDoNjxQw-eWUeNFVEKX1lffwBYCuUE6glq9zA9exa3m_tp5VxustM9FS6tR5TfgZdG9xW0pQkdQyy3dFoB8biSA8czTzn3OXl93iLmik2WeZLQqBTVVOxx527rm7mOTjNKBMqwcl-szxCAMb5ZTlodQj3u-PLYtFxzJEZiGJ-pPJUjKDye61VXDHex63bP_AtFMTuUT5wgrCCKNgBl-DgQE1Aee02_axSAb5COlGBOhROigfbDkSmNvuVcClJFET_qp37Fa2DdMOWSJ95tKB3xpUK0A20oH5sps4Ivjs6vDSg4Z3wuSD0NYY0NYVBLXWTZmTiJwRcLRByEZjwXR7tODpajwjwCs_h4epu1AxS9C2gIRGWILwjSImbXBwCC7qrYWk2WtMOQ4XgwgyheW5N7rGPU1n8NsIU39rLDQt52B858BPGLyi7oNS4YmqdLfc72ZkZx_Nfb_UWVpvjL4m8TumBmhcJWK2pxZJyWOMw.s2uq6vsHcVMJioA9LbyBlA');
//         attachmentRequest.setBody(body);
        
//         Http http = new Http();
//         System.debug('Sending HTTP request');

//         HttpResponse attachmentResponse = http.send(attachmentRequest);

//         System.debug('HTTP response status: ' + attachmentResponse.getStatus());

//         System.debug('Attachment response Body' + attachmentResponse.getBody());
//     }
// }


    @AuraEnabled(cacheable = true)
    public static string getPaymentAccounts(){
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String query = 'SELECT * FROM Account WHERE AccountType = \'Bank\'';
            String encodedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
            request.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/query?query=' + encodedQuery + '&minorversion=65');
            request.setMethod('GET');
            request.setHeader('Content-Type', 'text/plain');
            request.setHeader('Accept', 'application/json');
            request.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..gPrlQnWkgTtcBj8GZLPKnQ.UX0XvFN4ss419ihabgrfhQq3t4ZWTEs6ZJ6sozV1uwiqKYL2EyyWci4iDGmrE6dh8gGoMVdXWOh80PUOgaIV8Cvoo8X86KEWIsKCsIGla8DFV-Q6G0kCeO8Rc7xuaYFogTRjFUdmrKz4LM2nea0-mQ0Hr2w9WajzTGxcFguydNa3GuU9SeQGyjlzrsQsarlChKstCG6gFtJgemo47U6rVm6UaS2rlqC9B3tWggK71HOpdT5dhEUb4TQWVwvduuSgTz1itbNTfPB_VYjGPSdxBAIrybtGurXZRlGqSKqVjOVhff4Ok4fs9-FJVwnM_Fm-fLoPpwBF7ibd3w2U6CB827gnzMpvNBaxtZ0NoNKut45UmzZ-NxaGlT9QQZsXqIqIpwtSIF1ltr9HQYP-JSrKAF-FVvk7NvrE0H4iq4jgNi9R8-e2FmdLLmBFh8tWbl7wgSkULHplgir29eLk6bdRbNVheQdOyFlKa6sntqixDYcXWBtL5GcaqixTSn1_ipXhKkWJOSLAf331m9tH-UlIoDeoMQkhGYsaL_bSa0V3PNLioGaYXtGqdMB2QB1C1QDnpG_1sFGqXo7oGX4FsYQtT1C8FosJyp3Z3eb1nQ_Wt48y2p8kcocrzqc3WDTP-YksHdK8_PHbLF-K1KeuWW4J1ut0wc5W7YwpXzCoGvEl5yBMkzKdg3q5leYE8pKffLw24iU1sYZXcrhtaRYeZ8wNYYJi1-MYxI8yqqp9yFLj5TyS-uL8Y8DDGAe8qR5GElasIHdTPCE774I7WkSa5bTKStZrwBfPNaVM0sziEhDTOgCmKov9f3iK1ibdQVfCQkKuT9dIOgsLgApEOb55PCLPbfOtYVc7nap-k1HelWXRAcWiBTNUJpuYikzJ38LVyjikhWs9OYi7llcKJdlPVWZABw.N0P1CtVnhNMCQW21mJJTAw');
            HttpResponse response = http.send(request);
            System.debug('Reponse' + response );
            System.debug('Response Body' + response.getBody());
            return response.getBody();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable = true)
    public static string getPaymentAccounts2(){
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String query = 'SELECT * FROM Account WHERE AccountType = \'Credit Card\'';
            String encodedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
            request.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/query?query=' + encodedQuery + '&minorversion=65');
            request.setMethod('GET');
            request.setHeader('Content-Type', 'text/plain');
            request.setHeader('Accept', 'application/json');
            request.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..gPrlQnWkgTtcBj8GZLPKnQ.UX0XvFN4ss419ihabgrfhQq3t4ZWTEs6ZJ6sozV1uwiqKYL2EyyWci4iDGmrE6dh8gGoMVdXWOh80PUOgaIV8Cvoo8X86KEWIsKCsIGla8DFV-Q6G0kCeO8Rc7xuaYFogTRjFUdmrKz4LM2nea0-mQ0Hr2w9WajzTGxcFguydNa3GuU9SeQGyjlzrsQsarlChKstCG6gFtJgemo47U6rVm6UaS2rlqC9B3tWggK71HOpdT5dhEUb4TQWVwvduuSgTz1itbNTfPB_VYjGPSdxBAIrybtGurXZRlGqSKqVjOVhff4Ok4fs9-FJVwnM_Fm-fLoPpwBF7ibd3w2U6CB827gnzMpvNBaxtZ0NoNKut45UmzZ-NxaGlT9QQZsXqIqIpwtSIF1ltr9HQYP-JSrKAF-FVvk7NvrE0H4iq4jgNi9R8-e2FmdLLmBFh8tWbl7wgSkULHplgir29eLk6bdRbNVheQdOyFlKa6sntqixDYcXWBtL5GcaqixTSn1_ipXhKkWJOSLAf331m9tH-UlIoDeoMQkhGYsaL_bSa0V3PNLioGaYXtGqdMB2QB1C1QDnpG_1sFGqXo7oGX4FsYQtT1C8FosJyp3Z3eb1nQ_Wt48y2p8kcocrzqc3WDTP-YksHdK8_PHbLF-K1KeuWW4J1ut0wc5W7YwpXzCoGvEl5yBMkzKdg3q5leYE8pKffLw24iU1sYZXcrhtaRYeZ8wNYYJi1-MYxI8yqqp9yFLj5TyS-uL8Y8DDGAe8qR5GElasIHdTPCE774I7WkSa5bTKStZrwBfPNaVM0sziEhDTOgCmKov9f3iK1ibdQVfCQkKuT9dIOgsLgApEOb55PCLPbfOtYVc7nap-k1HelWXRAcWiBTNUJpuYikzJ38LVyjikhWs9OYi7llcKJdlPVWZABw.N0P1CtVnhNMCQW21mJJTAw');
            HttpResponse response = http.send(request);
            System.debug('Reponse' + response );
            System.debug('Response Body' + response.getBody());
            return response.getBody();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable = true)
    public static string getExpenseCategory(){
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String query = 'SELECT * FROM Account WHERE AccountType = \'Expense\'';
            String encodedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
            request.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/query?query=' + encodedQuery + '&minorversion=65');
            request.setMethod('GET');
            request.setHeader('Content-Type', 'text/plain');
            request.setHeader('Accept', 'application/json');
            request.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..gPrlQnWkgTtcBj8GZLPKnQ.UX0XvFN4ss419ihabgrfhQq3t4ZWTEs6ZJ6sozV1uwiqKYL2EyyWci4iDGmrE6dh8gGoMVdXWOh80PUOgaIV8Cvoo8X86KEWIsKCsIGla8DFV-Q6G0kCeO8Rc7xuaYFogTRjFUdmrKz4LM2nea0-mQ0Hr2w9WajzTGxcFguydNa3GuU9SeQGyjlzrsQsarlChKstCG6gFtJgemo47U6rVm6UaS2rlqC9B3tWggK71HOpdT5dhEUb4TQWVwvduuSgTz1itbNTfPB_VYjGPSdxBAIrybtGurXZRlGqSKqVjOVhff4Ok4fs9-FJVwnM_Fm-fLoPpwBF7ibd3w2U6CB827gnzMpvNBaxtZ0NoNKut45UmzZ-NxaGlT9QQZsXqIqIpwtSIF1ltr9HQYP-JSrKAF-FVvk7NvrE0H4iq4jgNi9R8-e2FmdLLmBFh8tWbl7wgSkULHplgir29eLk6bdRbNVheQdOyFlKa6sntqixDYcXWBtL5GcaqixTSn1_ipXhKkWJOSLAf331m9tH-UlIoDeoMQkhGYsaL_bSa0V3PNLioGaYXtGqdMB2QB1C1QDnpG_1sFGqXo7oGX4FsYQtT1C8FosJyp3Z3eb1nQ_Wt48y2p8kcocrzqc3WDTP-YksHdK8_PHbLF-K1KeuWW4J1ut0wc5W7YwpXzCoGvEl5yBMkzKdg3q5leYE8pKffLw24iU1sYZXcrhtaRYeZ8wNYYJi1-MYxI8yqqp9yFLj5TyS-uL8Y8DDGAe8qR5GElasIHdTPCE774I7WkSa5bTKStZrwBfPNaVM0sziEhDTOgCmKov9f3iK1ibdQVfCQkKuT9dIOgsLgApEOb55PCLPbfOtYVc7nap-k1HelWXRAcWiBTNUJpuYikzJ38LVyjikhWs9OYi7llcKJdlPVWZABw.N0P1CtVnhNMCQW21mJJTAw');
            HttpResponse response = http.send(request);
            System.debug('Reponse' + response );
            System.debug('Response Body' + response.getBody());
            return response.getBody();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable = true)
    public static string getVendors(){
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String query = 'SELECT * FROM vendor ';
            String encodedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
            request.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365344834000/query?query=' + encodedQuery + '&minorversion=65');
            request.setMethod('GET');
            request.setHeader('Content-Type', 'text/plain');
            request.setHeader('Accept', 'application/json');
            request.setHeader('authorization', 'Bearer eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..gPrlQnWkgTtcBj8GZLPKnQ.UX0XvFN4ss419ihabgrfhQq3t4ZWTEs6ZJ6sozV1uwiqKYL2EyyWci4iDGmrE6dh8gGoMVdXWOh80PUOgaIV8Cvoo8X86KEWIsKCsIGla8DFV-Q6G0kCeO8Rc7xuaYFogTRjFUdmrKz4LM2nea0-mQ0Hr2w9WajzTGxcFguydNa3GuU9SeQGyjlzrsQsarlChKstCG6gFtJgemo47U6rVm6UaS2rlqC9B3tWggK71HOpdT5dhEUb4TQWVwvduuSgTz1itbNTfPB_VYjGPSdxBAIrybtGurXZRlGqSKqVjOVhff4Ok4fs9-FJVwnM_Fm-fLoPpwBF7ibd3w2U6CB827gnzMpvNBaxtZ0NoNKut45UmzZ-NxaGlT9QQZsXqIqIpwtSIF1ltr9HQYP-JSrKAF-FVvk7NvrE0H4iq4jgNi9R8-e2FmdLLmBFh8tWbl7wgSkULHplgir29eLk6bdRbNVheQdOyFlKa6sntqixDYcXWBtL5GcaqixTSn1_ipXhKkWJOSLAf331m9tH-UlIoDeoMQkhGYsaL_bSa0V3PNLioGaYXtGqdMB2QB1C1QDnpG_1sFGqXo7oGX4FsYQtT1C8FosJyp3Z3eb1nQ_Wt48y2p8kcocrzqc3WDTP-YksHdK8_PHbLF-K1KeuWW4J1ut0wc5W7YwpXzCoGvEl5yBMkzKdg3q5leYE8pKffLw24iU1sYZXcrhtaRYeZ8wNYYJi1-MYxI8yqqp9yFLj5TyS-uL8Y8DDGAe8qR5GElasIHdTPCE774I7WkSa5bTKStZrwBfPNaVM0sziEhDTOgCmKov9f3iK1ibdQVfCQkKuT9dIOgsLgApEOb55PCLPbfOtYVc7nap-k1HelWXRAcWiBTNUJpuYikzJ38LVyjikhWs9OYi7llcKJdlPVWZABw.N0P1CtVnhNMCQW21mJJTAw');
            HttpResponse response = http.send(request);
            System.debug('Reponse' + response );
            System.debug('Response Body' + response.getBody());
            return response.getBody();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}