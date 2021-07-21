// public with sharing class NewsController {

//     @AuraEnabled
//     public static Map<String, Object> getNews(){
//         HttpRequest httpReq = new HttpRequest();
//         httpReq.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&apiKey=41e03f042764462dbefca9e0a5f98182');
//         httpReq.setMethod('GET');

//         Map<String, Object> newJsonData = new Map<String, Object>();
//         String strResponse = null;
//         try {
//             Http http = new Http();
//             HttpResponse httpRes = http.send(httpReq);
//             if(httpRes.getStatusCode() == 200){
//                 strResponse = httpRes.getBody();
//             } else {
//                 throw new CalloutException(httpRes.getbody());
//             }
//         } catch (Exception ex) {
//             throw ex;
//         }
//         if(!String.isBlank(strResponse)){
//             newJsonData = (Map<String, Object>)JSON.deserializeUntyped(strResponse);
//         }
//         if(!newJsonData.isEmpty()){
//             return newJsonData;
//         } else {
//             return null;
//         }
//     }
// }

public with sharing class NewsController {
    @AuraEnabled
    public static Map<String, Object> getNews(){
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=41e03f042764462dbefca9e0a5f98182');
        httpRequest.setMethod('GET');

        Map<String, Object> newsJsonData = new Map<String, Object>();
        String strResponse = null;

        try{
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);
            if(httpResponse.getStatusCode() == 200){
                strResponse = httpResponse.getBody();
            } else {
                throw new CalloutException(httpResponse.getBody());
            }

        } catch(Exception ex){
            throw ex;
        }

        if(!String.isBlank(strResponse)){
            newsJsonData = (Map<String, Object>)JSON.deserializeUntyped(strResponse);
        }
        if(!newsJsonData.isEmpty()){
            return newsJsonData;
        } else {
            return null;
        }
    }
}
