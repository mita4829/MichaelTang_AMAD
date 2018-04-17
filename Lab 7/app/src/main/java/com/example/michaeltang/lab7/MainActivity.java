package com.example.michaeltang.lab7;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity implements  ContactDetailFragment.ButtonClickListener, CategoryFragment.ContactsListListener{

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override public void itemClicked(long id){
        ContactDetailFragment frag = new ContactDetailFragment();
        frag.setTypeOfContact(0);
        FragmentTransaction ft = getFragmentManager().beginTransaction();
        ft.replace(R.id.fragment_contact_detail, frag);
        ft.addToBackStack(null);
        ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE);
        ft.commit();
    }

    @Override public void onBackPressed(){
        if(getFragmentManager().getBackStackEntryCount() > 0){
            getFragmentManager().popBackStack();
        }else{
            super.onBackPressed();
        }
    }

    @Override public void addcontactclicked(View view){
        ContactDetailFragment frag = (ContactDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_contact_detail);
        frag.addContact();
    }
}
