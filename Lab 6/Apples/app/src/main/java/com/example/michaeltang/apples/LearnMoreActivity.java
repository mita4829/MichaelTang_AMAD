package com.example.michaeltang.apples;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;

public class LearnMoreActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_learn_more);

        ActionBar actionBar = getActionBar();
        actionBar.setDisplayHomeAsUpEnabled(true);
    }


}
