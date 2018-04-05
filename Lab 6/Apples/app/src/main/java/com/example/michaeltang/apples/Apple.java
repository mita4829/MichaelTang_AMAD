package com.example.michaeltang.apples;

/**
 * Created by michaeltang on 4/4/18.
 */

public class Apple {
    private String name;
    private int imageResourceID;
    private Boolean isTart;

    private Apple(String _name, int _id, Boolean _isTart){
        this.name = _name;
        this.imageResourceID = _id;
        this.isTart = _isTart;
    }

    public static final Apple[] fruits = {
        /*Work here once images are done*/
            new Apple("Red Delicious", R.drawable.red_declious, false),
            new Apple("Golden Delicious", R.drawable.golden_declious, false),
            new Apple("Granny Smith", R.drawable.granny_smith, true),
    };

    public String getName(){
        return name;
    }

    public int getImageResourceID(){
        return imageResourceID;
    }

    public Boolean getIsTart(){
        return isTart;
    }

    public String toString(){
        return this.name;
    }
}
