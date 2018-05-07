package com.example.michaeltang.michael_tang_final;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.*;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //create listener
        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener(){
            public void onItemClick(AdapterView<?> listView, View view, int position, long id){
                String activityType = (String) listView.getItemAtPosition(position);
                Intent intent = new Intent(MainActivity.this, Activities.class);
                intent.putExtra("activityType", activityType);
                startActivity(intent);
            }
        };

        //get the list view
        ListView listview = (ListView) findViewById(R.id.listView);
        //add listener to the list view
        listview.setOnItemClickListener(itemClickListener);
    }
}
