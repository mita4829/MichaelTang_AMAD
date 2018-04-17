package com.example.michaeltang.lab7;


import android.app.AlertDialog;
import android.app.Fragment;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import java.util.ArrayList;


/**
 * A simple {@link Fragment} subclass.
 */
public class ContactDetailFragment extends Fragment implements View.OnClickListener {

    private ArrayAdapter<String> adapter;
    private long typeOfContact;
    private ButtonClickListener listener;

    interface ButtonClickListener{
        void addcontactclicked(View view);
    }
    public ContactDetailFragment() {
        // Required empty public constructor
    }

    @Override public void onClick(View view){
        if(listener != null){
            listener.addcontactclicked(view);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_contact_detail, container, false);
    }




    @Override public void onStart(){
        super.onStart();

        View view = getView();
        ListView listContacts = (ListView) view.findViewById(R.id.contactlistView);

        ArrayList<String> contactslist = new ArrayList<String>();
        contactslist = Contacts.myContacts[(int) typeOfContact].getContacts();
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, contactslist);
        listContacts.setAdapter(adapter);
        Button addNewContact = (Button) view.findViewById(R.id.button);
        addNewContact.setOnClickListener(this);
        registerForContextMenu(listContacts);
    }

    @Override public void onAttach(Context context){
        super.onAttach(context);
        listener = (ButtonClickListener)context;
    }


    public void addContact(){

        AlertDialog.Builder dialog = new AlertDialog.Builder(getActivity());

        final EditText edittext = new EditText(getActivity());

        dialog.setView(edittext);

        dialog.setTitle("Add new contact");

        //sets OK action
        dialog.setPositiveButton("Add", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {
                //get hero name entered
                String contactName = edittext.getText().toString();
                if(!contactName.isEmpty()){
                    // add hero
                    Contacts.myContacts[(int) typeOfContact].getContacts().add(contactName);
                    //refresh the list view
                    ContactDetailFragment.this.adapter.notifyDataSetChanged();
                }
            }
        });

        dialog.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int whichButton) {

            }
        });

        dialog.show();
    }

    public void setTypeOfContact(long value){
        this.typeOfContact = value;
    }

}
