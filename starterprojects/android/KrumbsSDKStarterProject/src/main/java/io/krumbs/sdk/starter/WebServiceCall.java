package io.krumbs.sdk.starter;

import android.util.Log;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.ByteArrayBuffer;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by maquebex on 3/3/2016.
 */
public class WebServiceCall {
    public static String getData(String url) {
        Log.d("NEXTGEN", "MAKING CALL");

        // string buffers the url
        StringBuffer buffer_string = new StringBuffer(url);
        String replyString = "";
        // instanciate an HttpClient
        HttpClient httpclient = new DefaultHttpClient();
        // instanciate an HttpGet
        HttpGet httpget = new HttpGet(buffer_string.toString());
        try {
            // get the responce of the httpclient execution of the url
            HttpResponse response = httpclient.execute(httpget);
            Log.d("NEXTGEN","RESPONSE "+response.getStatusLine().toString());
            InputStream is = response.getEntity().getContent();
            // buffer input stream the result
            BufferedInputStream bis = new BufferedInputStream(is);
            ByteArrayBuffer baf = new ByteArrayBuffer(20);
            int current = 0;
            while ((current = bis.read()) != -1) {
                baf.append((byte) current);
            }
            // the result as a string is ready for parsing
            replyString = new String(baf.toByteArray());
        } catch (Exception e) {
            Log.d("NEXTGEN","ERROR "+e.getMessage());

            e.printStackTrace();
        }
        // trim the whitespaces
        return replyString.trim();
    }

    public static int postData(String url, JSONObject postData) {
        // Create a new HttpClient and Post Header
        HttpClient httpclient = new DefaultHttpClient();
        HttpPost httppost = new HttpPost(url);
        int responsecode = -1;
        try {
            // Add your data
            StringEntity se = new StringEntity(postData.toString());
            se.setContentType("application/json;charset=UTF-8");
            se.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE,"application/json;charset=UTF-8"));
            httppost.setEntity(se);

            // Execute HTTP Post Request
            HttpResponse response = httpclient.execute(httppost);
            responsecode = response.getStatusLine().getStatusCode();
        } catch (ClientProtocolException e) {
            // TODO Auto-generated catch block
        } catch (IOException e) {
            // TODO Auto-generated catch block
        }
        return responsecode;
    }
}
