package com.example.michaeltang.apples;

import android.app.Activity;
import android.os.Bundle;
import android.widget.AdapterView;
import android.view.*;
import android.content.Intent;
import android.widget.ListView;

public class ApplesMainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_apples_main);

        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener(){
            public void onItemClick(AdapterView<?> listView, View view, int position, long id){
                String appletype = (String) listView.getItemAtPosition(position);

                Intent intent = new Intent(ApplesMainActivity.this, ApplesCategoryActivity.class);

                intent.putExtra("appletype", appletype);

                startActivity(intent);
            }
        };
        ListView listview = (ListView) findViewById(R.id.listView);
        listview.setOnItemClickListener(itemClickListener);
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.learn_more:
                Intent intent = new Intent(this, LearnMoreActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
