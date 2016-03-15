package io.krumbs.sdk.starter;

import android.os.AsyncTask;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by maquebex on 3/2/2016.
 */
public class FoursquareAPI extends AsyncTask{
    // the foursquare client_id and the client_secret
    final String CLIENT_ID = "DFBENNW14LOSV5NSX1QWFHDG035MFYL12FXFTJ3M2D0WJ2WP";
    final String CLIENT_SECRET = "IDVJTV0AMIESHPSSESJI5JVKGDAB1NHSOE5TIZNWQTRV14T5";
    double latitude;
    double longtitude;
    String krumbsURL = "";
    String temp="";
    public static boolean bFetchCategories = true;
    public ArrayList<String> foodCategories = new ArrayList<String>();
    public ArrayList<String> entertainmentCategories = new ArrayList<String>();
    public ArrayList<String> sportCategories = new ArrayList<String>();
    private List<String> entertainmentTopCategories = Arrays.asList("Arts & Entertainment","Event","Nightlife Spot");
    private List<String> sportTopCategories = Arrays.asList("Outdoors & Recreation");

    public FoursquareAPI(){}
    public FoursquareAPI(double lat,double longt,String url){
        latitude=lat;
        longtitude = longt;
        krumbsURL = url;
    }
    @Override
    protected Object doInBackground(Object[] params) {
        // make Call to the url
        // Fetch Category list.
        if(bFetchCategories)
        {
            String categoryJSON =WebServiceCall.getData("https://api.foursquare.com/v2/venues/categories?client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=20130815");
            parseCategories(categoryJSON);
            bFetchCategories = false;
        }

        //Fetch Krumbs Category
        temp = WebServiceCall.getData(krumbsURL);
        int type = getTypeFromKrumbs(temp);

        Log.d("NEXTGEN","HERE");
        temp = WebServiceCall.getData("https://api.foursquare.com/v2/venues/search?client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=20130815&ll=" + latitude + "," + longtitude);
        Log.d("NEXTGEN","FS Res "+temp);
        ArrayList<String> tagsFromFourSquare = parseResult(temp,type);
        buildJSONandPostData(tagsFromFourSquare);

        return "";

    }
    protected void onPostExecute(String result) {
        Log.d("NEXTGEN : onPostExecute", result);
    }

    protected int getTypeFromKrumbs(String data)
    {
        int type = 0;

        try{
            String categoryName = "Food";
            JSONObject obj = new JSONObject(data);
            JSONArray medArr = obj.getJSONArray("media");
            if(medArr.length() > 0)
            {
                JSONArray whyArr = medArr.getJSONObject(0).getJSONArray("why");
                if(whyArr.length() > 0)
                {
                    categoryName = whyArr.getJSONObject(0).getString("intent_category_name");
                }
            }

            if(categoryName.equals("Entertainment"))
            {
                type = 1;
            }
            else if(categoryName.equals("Sports"))
            {
                type = 2;
            }
        }
        catch(JSONException e) {
            e.printStackTrace();
        }

        return type;
    }


    protected ArrayList<String> parseResult(String result,int type)
    {
        // Parse JSON to get the tags associated.
        ArrayList<String> tags = new ArrayList<String>();
        try{
            JSONObject json = new JSONObject(result);
            JSONObject response = json.getJSONObject("response");
            JSONArray venues = response.getJSONArray("venues");
            for(int i = 0; i < venues.length() ; i++)
            {
                JSONArray categories = venues.getJSONObject(i).getJSONArray("categories");
                for(int j = 0; j < categories.length() ; j++)
                {
                    String currCategory = categories.getJSONObject(j).getString("name");
                    if((type == 0 && foodCategories.contains(currCategory))
                            || (type == 1 && entertainmentCategories.contains(currCategory))
                            || (type == 2 && sportCategories.contains(currCategory)))
                    {
                        tags.add(currCategory);
                        break;
                    }
                }
                if(tags.size()!=0)
                    break;
            }
        }
        catch(JSONException e) {
            e.printStackTrace();
        }
        for(int i = 0 ;i < tags.size() ; i++)
        {
            Log.d("NEXTGEN : tags",tags.get(i));
        }
        return tags;
    }

    protected void parseCategories(String result)
    {
        // parse category list and get required categories
        try{
            JSONArray categoryArr = new JSONObject(result).getJSONObject("response").getJSONArray("categories");
            for(int i = 0 ; i < categoryArr.length() ; i++)
            {
                String categoryName = categoryArr.getJSONObject(i).getString("name");
                if(categoryName.equals("Food"))
                {
                    parseSubCategories(categoryArr.getJSONObject(i),0);
                }
                else if(entertainmentTopCategories.contains(categoryName))
                {
                    parseSubCategories(categoryArr.getJSONObject(i),1);
                }
                else if(sportTopCategories.contains(categoryName))
                {
                    parseSubCategories(categoryArr.getJSONObject(i),2);
                }
            }
        }
        catch(JSONException e)
        {
            e.printStackTrace();
        }
    }

    protected void parseSubCategories(JSONObject result,int type)
    {
        // type : 0 - food, 1 - entertainment, 2 - sport
        try{
            JSONArray currArray = result.getJSONArray("categories");
            for(int i = 0 ; i < currArray.length() ; i++)
            {
                JSONObject currObject = currArray.getJSONObject(i);
                String currCategoryName = currObject.getString("name");
                if(0 == type)
                    foodCategories.add(currCategoryName);
                else if(1 == type)
                    entertainmentCategories.add(currCategoryName);
                else
                    sportCategories.add(currCategoryName);

                parseSubCategories(currObject,type);
            }
        }
        catch(JSONException e)
        {
            e.printStackTrace();
        }
    }

    protected void buildJSONandPostData(ArrayList<String> tags)
    {
        JSONObject checkin = new JSONObject();
        try {

            checkin.put("krumbs", krumbsURL);
            JSONArray jsonTags = new JSONArray();
            for(int i = 0 ; i < tags.size() ; i++)
            {
                jsonTags.put(tags.get(i));
            }
            checkin.put("loc_tags",jsonTags);
            checkin.put("uid",MainActivity.userID);
        }
        catch (JSONException e)
        {
            e.printStackTrace();
        }
        // make post call to backend
        int retCode = WebServiceCall.postData("http://ellipse.herokuapp.com/checkin", checkin);
        //int retCode = WebServiceCall.postData("http://192.168.0.25:5000/checkin", checkin);
    }
}
