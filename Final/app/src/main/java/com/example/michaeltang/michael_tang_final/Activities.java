package com.example.michaeltang.michael_tang_final;

import android.app.ListActivity;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.content.*;
import android.widget.*;
import android.widget.AdapterView.*;
import android.view.*;
import android.net.*;

import java.util.List;
import java.util.UUID;

public class Activities extends AppCompatActivity {

    private String activityType;
    private ArrayAdapter<String> listAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_activities);

        Intent intent = getIntent();
        this.activityType = intent.getStringExtra("activityType");

        ListView listView = (ListView) findViewById(R.id.list);


        switch(activityType){
            case "Cardio":
                listAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, WorkoutData.cardio);
                break;
            case "Strength":
                listAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, WorkoutData.strength);
                break;
            case "Flexibility":
                listAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, WorkoutData.flexibility);
                break;
            default:
                listAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, WorkoutData.cardio);
                break;
        }

        listView.setAdapter(listAdapter);

        FloatingActionButton fab = (FloatingActionButton)findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                LinearLayout layout = new LinearLayout(Activities.this);
                layout.setOrientation(LinearLayout.VERTICAL);

                final EditText activityName = new EditText(Activities.this);
                activityName.setHint("Activity name");
                layout.addView(activityName);
                final EditText url = new EditText(Activities.this);
                url.setHint("URL");
                layout.addView(url);

                //create alert dialog
                AlertDialog.Builder dialog = new AlertDialog.Builder(Activities.this);
                dialog.setTitle("Add Activity");
                dialog.setView(layout);
                dialog.setPositiveButton("Save", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        //get book name entered
                        final String newActivityName = activityName.getText().toString();
                        final String newURL = url.getText().toString();

                        if(!newActivityName.isEmpty() && !newURL.isEmpty()) {
                            appendToArray(newActivityName, newURL);
                        }
                    }
                });
                dialog.setNegativeButton("Cancel", null);
                dialog.show();
            }

        });

        listView.setOnItemLongClickListener(new OnItemLongClickListener(){
            @Override
            public boolean onItemLongClick(AdapterView<?> arg0, View arg1,
                                           int pos, long id){
                removeAtIndex(pos);
                return true;

            }
        });

        listView.setOnItemClickListener(new OnItemClickListener() {
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                openURLAtIndex(position);
            }
        });



    }

    private void appendToArray(String activityName, String URL){
        switch(activityType){
            case "Cardio":
                WorkoutData.cardio.add(activityName);
                WorkoutData.cardioURL.add(URL);
                break;
            case "Strength":
                WorkoutData.strength.add(activityName);
                WorkoutData.strengthURL.add(URL);
                break;
            case "Flexibility":
                WorkoutData.flexibility.add(activityName);
                WorkoutData.flexibilityURL.add(URL);
                break;
            default:
                break;
        }
        ListView listView = (ListView) findViewById(R.id.list);
        listView.setAdapter(listAdapter);
    }

    private void removeAtIndex(int pos){
        switch(activityType){
            case "Cardio":
                WorkoutData.cardio.remove(pos);
                WorkoutData.cardioURL.remove(pos);
                break;
            case "Strength":
                WorkoutData.strength.remove(pos);
                WorkoutData.strengthURL.remove(pos);
                break;
            case "Flexibility":
                WorkoutData.flexibility.remove(pos);
                WorkoutData.flexibilityURL.remove(pos);
                break;
            default:
                break;
        }
        ListView listView = (ListView) findViewById(R.id.list);
        listView.setAdapter(listAdapter);
    }
    private void openURLAtIndex(int pos){
        String URL = new String();
        switch(activityType){
            case "Cardio":
                URL = WorkoutData.cardioURL.get(pos);
                break;
            case "Strength":
                URL = WorkoutData.strengthURL.get(pos);
                WorkoutData.strengthURL.remove(pos);
                break;
            case "Flexibility":
                URL = WorkoutData.flexibilityURL.get(pos);
                break;
            default:
                URL = "https://google.com";
                break;
        }
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(URL));
        startActivity(browserIntent);
    }
}
