package io.krumbs.sdk.starter;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;
import java.util.HashMap;

public class RecoListActivity extends AppCompatActivity {
    ArrayList<HashMap<String,String>> data = new ArrayList<HashMap<String, String>>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_reco_list);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        FloatingActionButton home = (FloatingActionButton)findViewById(R.id.capture);

        Bundle extras = getIntent().getExtras();
        if(extras != null)
        {
            String jsonData = extras.getString("jsonData");
        }

        HashMap<String,String> item1 = new HashMap<String,String>();
        item1.put("Name","Starbucks");
        item1.put("Location","Irvine");
        item1.put("Category","Cafe");

        HashMap<String,String> item2 = new HashMap<String,String>();
        item2.put("Name", "Subway");
        item2.put("Location","San diego");
        item2.put("Category","sandwich");

        data.add(item1);
        data.add(item2);

        ListView listView = (ListView)findViewById(R.id.listView);
        ArrayAdapter<HashMap<String,String>> adapter = new ArrayAdapter<HashMap<String,String>>(this,android.R.layout.simple_list_item_1 ,data);
        listView.setAdapter(adapter);

        home.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                backtoHomepage();
            }
        });
    }

    public void backtoHomepage(){
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent);
    }

}
