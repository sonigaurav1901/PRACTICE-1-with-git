@RestResource(urlMapping='/htmlWaliApi/')
global class ReturnHTMLPage {
    @HTTPGET
    global static void getHTML() {
        RestResponse res = RestContext.response;
        res.responseBody= Blob.valueOf('<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8"><TITLE>302 Moved</TITLE></HEAD><BODY onload=" location.href="#myanchor" "><H1>302 Moved</H1><A id="myanchor" HREF="https://lh3.googleusercontent.com/places/AAcXr8ryyytlg_114LPqEQIHoNpA9aCqtcXx7U-PjtZ3hAZJGjLW2tmuhJOFgJm-7lCMJD0jwF7TvGrMK4TbqpKsMDNm8GOJZIvgG2c=s1600-w400-h400">here</A></BODY></HTML>');
    }
}