package com.example.michaeltang.michael_tang_final;

import java.util.ArrayList;

/**
 * Created by michaeltang on 5/6/18.
 */

public class WorkoutData {
    private String name;
    private WorkoutData(String _name){
        this.name = _name;
    }

    public static ArrayList<String> cardio = new ArrayList<>();
    public static ArrayList<String> strength = new ArrayList<>();
    public static ArrayList<String> flexibility = new ArrayList<>();
    public static ArrayList<String> cardioURL = new ArrayList<>();
    public static ArrayList<String> strengthURL = new ArrayList<>();
    public static ArrayList<String> flexibilityURL = new ArrayList<>();

    public String getName(){
        return this.name;
    }
    public String toString(){
        return this.name;
    }

}
