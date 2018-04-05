package com.example.michaeltang.apples;

import android.app.ListActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.content.Intent;
import android.widget.ListView;

public class ApplesCategoryActivity extends ListActivity {
    private String appletype;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = getIntent();
        appletype = intent.getStringExtra("appletype");
        ListView listApples = getListView();
        ArrayAdapter<Apple> listAdapter;
        switch(appletype){
            case "Fruits":
                listAdapter = new ArrayAdapter<Apple>(this, android.R.layout.simple_list_item_1, Apple.fruits);
                break;
            default:
                listAdapter = new ArrayAdapter<Apple>(this, android.R.layout.simple_list_item_1, Apple.fruits);
        }
        listApples.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(ApplesCategoryActivity.this, ApplesActivity.class);
        intent.putExtra("appleid", (int) id);
        startActivity(intent);
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
