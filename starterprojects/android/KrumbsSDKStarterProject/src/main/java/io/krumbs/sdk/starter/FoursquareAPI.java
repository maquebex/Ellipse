package io.krumbs.sdk.starter;

import android.os.AsyncTask;
import android.util.Log;

/**
 * Created by maquebex on 3/2/2016.
 */
public class FoursquareAPI extends AsyncTask{
    // the foursquare client_id and the client_secret
    final String CLIENT_ID = "DFBENNW14LOSV5NSX1QWFHDG035MFYL12FXFTJ3M2D0WJ2WP";
    final String CLIENT_SECRET = "IDVJTV0AMIESHPSSESJI5JVKGDAB1NHSOE5TIZNWQTRV14T5";
    double latitude;
    double longtitude;
    String temp="";

    public FoursquareAPI(){}
    public FoursquareAPI(double lat,double longt){
        latitude=lat;
        longtitude = longt;
    }
    @Override
    protected Object doInBackground(Object[] params) {
        // make Call to the url
        Log.d("NEXTGEN","HERE");
        temp = WebServiceCall.getData("https://api.foursquare.com/v2/venues/search?client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=20130815&ll="+latitude+","+longtitude);
        Log.d("NEXTGEN","FS Res "+temp);
        return "";

    }
    protected void onPostExecute(String result) {
        Log.d("NEXTGEN", result);
    }
}
