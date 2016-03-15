package io.krumbs.sdk.starter;

import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.util.Log;

/**
 * Created by phani on 3/10/16.
 */
public class RecommendationAPI extends AsyncTask {
    final String ENDPOINT = "http://ellipse.herokuapp.com/recommend";//"http://192.168.0.25:5000/recommend";
    double latitude;
    double longtitude;

    private Activity mainActivity;

    public RecommendationAPI(){}
    public RecommendationAPI(Activity activity,double lat, double longt){
        latitude = lat;
        longtitude = longt;
        mainActivity = activity;
    }
    @Override
    protected Object doInBackground(Object[] params) {
        String response = WebServiceCall.getData(ENDPOINT+"?uid="+MainActivity.userID+"&loc=" + latitude + "," + longtitude);
        Log.d("NEXTGEN", "WEB RES from EVENTFUL" + response);
        startRecoActivity(response);
        return "";
    }

    private void startRecoActivity(String data)
    {
        Intent intent = new Intent(mainActivity.getApplicationContext(), RecoListActivity.class);
        intent.putExtra("jsonData",data);
        mainActivity.startActivity(intent);
    }

}
