package com.example.michaeltang.catorhat;

import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.*;
import android.view.*;

import java.util.ArrayList;

public class Results_Activity extends AppCompatActivity {
    static ArrayList<String> results = new ArrayList<String>();
    ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_results_);
        adapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, results){
            //Set textView elements to have white text color
            @Override
            public View getView(int position, View c_view, ViewGroup p){
                View view = super.getView(position, c_view, p);
                TextView textView = view.findViewById(android.R.id.text1);
                textView.setTextColor(Color.WHITE);
                return view;
            }
        };
        ListView listView = findViewById(R.id.resultListView);

        listView.setAdapter(adapter);

        String score = getIntent().getStringExtra("SCORE_RESULT");
        notify(score);
    }

    public void notify(String newResult){
        int score = Integer.valueOf(newResult);
        if(score == 0){
            newResult += " lol fail";
        }
        results.add(newResult);
        adapter.notifyDataSetChanged();
    }
}
