package com.example.michaeltang.lab7;

import android.widget.ArrayAdapter;

import java.util.ArrayList;
import java.util.Arrays;
/**
 * Created by michaeltang on 4/16/18.
 */

public class Contacts {
    private String category; /*Can be school or private*/
    private ArrayList<String> contacts = new ArrayList<>();

    private Contacts(String _category, ArrayList<String> _contacts){
        this.category = _category;
        this.contacts = new ArrayList<String>(_contacts);
    }

    public static final Contacts[] myContacts = {
            new Contacts("school", new ArrayList<String>(Arrays.asList("Michael"))),
            new Contacts("private", new ArrayList<String>(Arrays.asList("Michael")))
    };

    public String getCategory(){
        return category;
    }

    public ArrayList<String> getContacts(){
        return contacts;
    }

    public String toString() {
        return this.category;
    }
}
