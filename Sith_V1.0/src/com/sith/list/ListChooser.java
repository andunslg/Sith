package com.sith.list;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemLongClickListener;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.graphics.util.Dynamics;
import com.sith.main.R;


public class ListChooser extends Activity {

    /** Id for the toggle rotation menu item */
    private static final int TOGGLE_ROTATION_MENU_ITEM = 0;

    /** Id for the toggle lighting menu item */
    private static final int TOGGLE_LIGHTING_MENU_ITEM = 1;

    /** The list view */
    private MyListView mListView;

    private static class Emotion {

        
        String name;
        String mNumber;
        Drawable contactImage;

        public Emotion(final String s, final String number,Drawable contactImage) {
            name = s;
            mNumber = number;
            this.contactImage=contactImage;
        }

    }

    @Override
    public void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.list_view);

        final ArrayList<Emotion> contacts = populateEmotionsList(this);
        final MyAdapter adapter = new MyAdapter(this, contacts);

        mListView = (MyListView)findViewById(R.id.my_list);
        mListView.setAdapter(adapter);

        mListView.setDynamics(new SimpleDynamics(0.9f, 0.6f));

        mListView.setOnItemClickListener(new OnItemClickListener() {
            public void onItemClick(final AdapterView<?> parent, final View view,
                    final int position, final long id) {
                final String message = "OnClick: " + contacts.get(position).name;
                Toast.makeText(ListChooser.this, message, Toast.LENGTH_SHORT).show();
            }
        });

        mListView.setOnItemLongClickListener(new OnItemLongClickListener() {
            public boolean onItemLongClick(final AdapterView<?> parent, final View view,
                    final int position, final long id) {
                final String message = "OnLongClick: " + contacts.get(position).name;
                Toast.makeText(ListChooser.this, message, Toast.LENGTH_SHORT).show();
                return true;
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(final Menu menu) {
        menu.add(Menu.NONE, TOGGLE_ROTATION_MENU_ITEM, 0, "Toggle Rotation");
        menu.add(Menu.NONE, TOGGLE_LIGHTING_MENU_ITEM, 1, "Toggle Lighting");
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(final MenuItem item) {
        switch (item.getItemId()) {
            case TOGGLE_ROTATION_MENU_ITEM:
                mListView.enableRotation(!mListView.isRotationEnabled());
                return true;

            case TOGGLE_LIGHTING_MENU_ITEM:
                mListView.enableLight(!mListView.isLightEnabled());
                return true;

            default:
                return false;
        }
    }

    private ArrayList<Emotion> populateEmotionsList(Context context) {
        final ArrayList<Emotion> list = new ArrayList<Emotion>();
        context.getResources().getDrawable(R.drawable.ic_launcher);
        list.add(new Emotion("Happy", null,context.getResources().getDrawable(R.drawable.rabbit)));
        list.add(new Emotion("Sad", null,context.getResources().getDrawable(R.drawable.rabbit)));
        list.add(new Emotion("Boring", null,context.getResources().getDrawable(R.drawable.rabbit)));
        list.add(new Emotion("Happy", null,context.getResources().getDrawable(R.drawable.rabbit)));
        list.add(new Emotion("Happy", null,context.getResources().getDrawable(R.drawable.rabbit)));
        list.add(new Emotion("Happy", null,context.getResources().getDrawable(R.drawable.rabbit)));
     
        return list;
    }

    /**
     * Adapter class to use for the list
     */
    private static class MyAdapter extends ArrayAdapter<Emotion> {

        
        public MyAdapter(final Context context, final ArrayList<Emotion> list) {
            super(context, 0, list);
        }

        @Override
        public View getView(final int position, final View convertView, final ViewGroup parent) {
            View view = convertView;
            if (view == null) {
                view = LayoutInflater.from(getContext()).inflate(R.layout.list_item, null);
            }

            final TextView name = (TextView)view.findViewById(R.id.contact_name);
            if (position == 14) {
                name.setText("This is a long text that will make this box big. "
                        + "Really big. Bigger than all the other boxes. Biggest of them all.");
            } else {
                name.setText(getItem(position).name);
            }

//            final TextView number = (TextView)view.findViewById(R.id.contact_number);
//            number.setText(getItem(position).mNumber);

            final ImageView photo = (ImageView)view.findViewById(R.id.contact_photo);
            photo.setImageDrawable(getItem(position).contactImage);

            return view;
        }
    }

    /**
     * A very simple dynamics implementation with spring-like behavior
     */
    class SimpleDynamics extends Dynamics {

        /** The friction factor */
        private float mFrictionFactor;

        /** The snap to factor */
        private float mSnapToFactor;

        /**
         * Creates a SimpleDynamics object
         * 
         * @param frictionFactor The friction factor. Should be between 0 and 1.
         *            A higher number means a slower dissipating speed.
         * @param snapToFactor The snap to factor. Should be between 0 and 1. A
         *            higher number means a stronger snap.
         */
        public SimpleDynamics(final float frictionFactor, final float snapToFactor) {
            mFrictionFactor = frictionFactor;
            mSnapToFactor = snapToFactor;
        }

        @Override
        protected void onUpdate(final int dt) {
            // update the velocity based on how far we are from the snap point
            mVelocity += getDistanceToLimit() * mSnapToFactor;

            // then update the position based on the current velocity
            mPosition += mVelocity * dt / 1000;

            // and finally, apply some friction to slow it down
            mVelocity *= mFrictionFactor;
        }
    }
}
