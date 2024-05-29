@RestResource(urlMapping='/accountOperations')
global class practice_InterOrg_Acc_Operations {

    @HttpPost
    global static String createAccount(String name,String phone,String accIndustry){
        try {
            Account acc = new Account();
            acc.Name = name;
            acc.Phone = phone;
            acc.Industry = accIndustry;

            insert acc;
            return acc.Id;
        } catch(Exception ex) {
            System.debug('error occur '+ex.getMessage());
        }
        return null;
    }

    @HttpGet
    global static Account getAccount() {
        try {
            String accountPersonEmail = '';
            if( accountPersonEmail != null & accountPersonEmail != '' ) {
                Account acc = [SELECT Id,Name,PersonEmail,Phone,Industry FROM Account WHERE PersonEmail = :accountPersonEmail];
                return acc;
            }
        } catch(Exception ex) {
            System.debug('error occur '+ex.getMessage());
        }
        return null;
    }



    // Public static void getAccessTocken() {

    //     String baseUrl = 'https://login.salesforce.com/services/oauth2/token';
    //     String userName = 'gaurav_soni@practice.com';
    //     String userPassword = '7Gaurav7';
    //     String userAccessTocken = '9J42w7aWPJuchY4p6fTabiS1r';
    //     String clientId = '3MVG9wt4IL4O5wvJJYDy.rz814XIXVdwMkPYVU.PgNNZZBEY0ZwrwAFHetVNL0zKtTEKP1D7PWQn9D0XueApE';
    //     String clientSecreat = 'BCD1BBC04335F8EAE1D415EE014C25675417113B04B3086CCCAF499D8CF9B506'; 
    //     String reqBody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecreat+'&password='+userPassword+''+userAccessTocken;

    //     HTTP httpInstance = new HTTP();
    //     HTTPRequest  httpReq = new HTTPRequest();
    //     httpReq.setMethod('POST');
    //     httpReq.setBody(reqBody);


    //     httpReq.setEndpoint(baseUrl);

    //     HTTPResponse httpRes = httpInstance.send(httpReq);

    //     System.debug('api response is ==> '+httpRes);
    // }
}