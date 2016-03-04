package io.krumbs.sdk.starter;

import android.os.AsyncTask;
import android.util.Log;

/**
 * Created by maquebex on 3/3/2016.
 */
public class EventfulAPI extends AsyncTask{
    final String APPLICATION_KEY = "RD5rDpTc3DGGg7Fg";
    double latitude;
    double longtitude;

    public EventfulAPI(){}
    public EventfulAPI(double lat, double longt){
        latitude = lat;
        longtitude = longt;
    }

    @Override
    protected Object doInBackground(Object[] params) {
        String response = WebServiceCall.makeCall("http://api.eventful.com/rest/events/search?app_key="+APPLICATION_KEY+"&where=" + latitude + "," + longtitude);
        Log.d("NEXTGEN", "WEB RES from EVENTFUL" + response);
        return "";
    }
}
