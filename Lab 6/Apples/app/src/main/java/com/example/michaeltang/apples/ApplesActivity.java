package com.example.michaeltang.apples;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class ApplesActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_apples);

        setContentView(R.layout.activity_apples);

        int applenum = (Integer)getIntent().getExtras().get("appleid");
        Apple apple = Apple.fruits[applenum];

        ImageView appleImage = (ImageView)findViewById(R.id.appleImageView);
        appleImage.setImageResource(apple.getImageResourceID());

        TextView appleName = (TextView)findViewById(R.id.apple_name);
        appleName.setText(apple.getName());

        TextView appleTartness = (TextView)findViewById(R.id.tartText);
        if(apple.getIsTart()){
            appleTartness.setText("Tart Apple");
        }else{
            appleTartness.setText("Sweet Apple");
        }
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
