package com.example.michaeltang.catorhat;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.*;
import android.widget.*;
import java.util.*;
import android.content.*;

public class MainActivity extends AppCompatActivity {
    static final int[] imageValues = {R.drawable.h0, R.drawable.h1, R.drawable.h2, R.drawable.c0, R.drawable.c1, R.drawable.c2};
    final int delta = 1000 * 10; // Delta is the time in ms between image that the user has to answer

    private int userChoice = 0; // Choice is the value the user picked: 0 => Nothing, 1 => Cat, 2 => Hat
    private int expectedChoice = 1; // The correct answer. 1 => Cat, 2 => HaRR.

    private Timer timer;
    private int accTime = 0;
    private int accCorrect = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ImageView imageView = findViewById(R.id.catOrHatImageView);
        imageView.setImageResource(imageValues[imageValues.length-1]);

        Button catButton = findViewById(R.id.catButton);
        catButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                System.out.println("Meow?");
                userChoice = 1;
            }
        });

        Button hatButton = findViewById(R.id.hatButton);
        hatButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                System.out.println("Hat?");
                userChoice = 2;
            }
        });

        timer = new Timer();
        startGame();

    }

    @Override
    protected void onResume(){
        super.onResume();
        System.out.println("onResumeCalled!");
        accCorrect = 0;
        accTime = 0;
        timer = new Timer();
        startGame();
    }

    private void startGame(){
        Context context = getApplicationContext();
        CharSequence text = "Begin!";
        int duration = Toast.LENGTH_SHORT;

        Toast toast = Toast.makeText(context, text, duration);
        toast.show();

        final Timer timerx = new Timer();
        final TimerTask timerTaskx = new TimerTask() {
            @Override
            public void run() {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        Calendar c = Calendar.getInstance();
                        final int ms = c.get(Calendar.MILLISECOND);

                        if(accTime > delta){
                            System.out.println("Game has ended. Score: "+accCorrect);
                            timerx.cancel();
                            timerx.purge();
                            //Create intent and move to the results
                            Intent intent = new Intent(getBaseContext(), Results_Activity.class);
                            intent.putExtra("SCORE_RESULT", String.valueOf(accCorrect));
                            startActivity(intent);
                        }
                        //User chose the wrong answer
                        if(userChoice == expectedChoice){
                            System.out.println("Correct");
                            accCorrect += 1;
                            getNextImage();
                        }

                        //Accumulate time and reset choice
                        accTime += ms;
                        userChoice = 0;
                    }
                });
            }
        };

        timerx.schedule(timerTaskx, 2000, 500);

//        timer.schedule(new TimerTask() {
//            @Override
//            public void run() {
//                runOnUiThread(new Runnable() {
//                    @Override
//                    public void run() {
//                        Calendar c = Calendar.getInstance();
//                        final int ms = c.get(Calendar.MILLISECOND);
//
//                        if(accTime > delta){
//                            System.out.println("Game has ended. Score: "+accCorrect);
//                            timer.cancel();
//                            timer.purge();
//                            //Create intent and move to the results
//                            Intent intent = new Intent(getBaseContext(), Results_Activity.class);
//                            intent.putExtra("SCORE_RESULT", String.valueOf(accCorrect));
//                            startActivity(intent);
//                        }
//                        //User chose the wrong answer
//                        if(userChoice == expectedChoice){
//                            System.out.println("Correct");
//                            accCorrect += 1;
//                            getNextImage();
//                        }
//
//                        //Accumulate time and reset choice
//                        accTime += ms;
//                        userChoice = 0;
//                    }
//                });
//            }
//        },2000,500);


    }

    private void getNextImage(){
        ImageView imageView = findViewById(R.id.catOrHatImageView);

        //Get a random index value
        Random number = new Random();
        int rand = number.nextInt(imageValues.length); // [0, length of imageValues)
        if(rand >= imageValues.length / 2){
            //If random index is greater than or equal to the upper half, it is a
            //cat image
            expectedChoice = 1;
        }else{
            expectedChoice = 2;
        }
        //Set a new image
        imageView.setImageResource(imageValues[rand]);
    }

}
