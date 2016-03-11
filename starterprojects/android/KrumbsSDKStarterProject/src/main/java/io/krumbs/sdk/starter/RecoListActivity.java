package io.krumbs.sdk.starter;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;

public class RecoListActivity extends AppCompatActivity {
    ArrayList<HashMap<String,String>> data = new ArrayList<HashMap<String, String>>();
    JSONArray jsonArr;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reco_list);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        FloatingActionButton home = (FloatingActionButton)findViewById(R.id.capture);
        try {
            jsonArr = new JSONArray(getIntent().getStringExtra("jsonData"));
            ArrayList<HashMap<String,String>> responses = parseJsonData(jsonArr);
            ArrayList<String> listValues = new ArrayList<String>();
            for(int i = 0 ; i < responses.size() ; i++)
            {
                String item = responses.get(i).get("title") + "\n" + responses.get(i).get("desc");
                listValues.add(item);
            }
            ListView listView = (ListView) findViewById(R.id.listView);
            ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,R.layout.list_row_item,listValues);
            listView.setAdapter(adapter);
            home.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    backtoHomepage();
                }
            });
        } catch (JSONException e){
            e.printStackTrace();
        }
    }

    public void backtoHomepage(){
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent);
    }

    public ArrayList<HashMap<String, String>>  parseJsonData(JSONArray jsondata) {
        ArrayList<HashMap<String,String>> responseData = new ArrayList<HashMap<String, String>>();
        try{
            for(int i=0;i<jsondata.length();i++) {
               HashMap<String, String> jsonRecord = new HashMap<String, String>();
               String title = (String)((JSONObject)jsondata.get(i)).get("title");
               String desc = (String)((JSONObject)jsondata.get(i)).get("desc");
               String url = (String)((JSONObject)jsondata.get(i)).get("url");
               jsonRecord.put("title",title);
               jsonRecord.put("desc",desc);
               jsonRecord.put("url",url);

               responseData.add(jsonRecord);
            }
        } catch (JSONException e){
            e.printStackTrace();
        }

        return responseData;
    }
}
