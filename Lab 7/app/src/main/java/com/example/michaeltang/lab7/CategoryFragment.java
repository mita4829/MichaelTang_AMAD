package com.example.michaeltang.lab7;


import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;



/**
 * A simple {@link Fragment} subclass.
 */
public class CategoryFragment extends Fragment implements AdapterView.OnItemClickListener {


    public CategoryFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_category, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();
        if (view != null){

            ListView listContacts = (ListView) view.findViewById(R.id.listView);
            ArrayAdapter<Contacts> listAdapter = new ArrayAdapter<Contacts>(getActivity(), android.R.layout.simple_list_item_1, Contacts.myContacts);
            listContacts.setAdapter(listAdapter);
            listContacts.setOnItemClickListener(this);
        }
    }

    interface ContactsListListener {
        void itemClicked(long id);
    }

    private ContactsListListener listener;

    @Override public void onAttach(Context context){
        super.onAttach(context);
        listener = (ContactsListListener) context;
    }

    @Override public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if (listener != null){
            listener.itemClicked(id);
        }
    }
}
