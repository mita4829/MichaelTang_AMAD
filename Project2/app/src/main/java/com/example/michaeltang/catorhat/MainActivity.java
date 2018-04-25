package com.example.michaeltang.catorhat;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.*;
import android.view.*;
import android.content.Intent;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button button = (Button)findViewById(R.id.catButton);

    }

    public void transition(View v)
    {
        Intent intent = new Intent(this, Login.class);
        startActivity(intent);
    }

}
