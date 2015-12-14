package com.krumbs.getkrumbs.sdk.reachoapp;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;

import com.joanzapata.iconify.IconDrawable;
import com.joanzapata.iconify.fonts.FontAwesomeIcons;

import io.krumbs.context.intent.ExpressionalIntent;
import io.krumbs.krumbscamera.adapter.ContextSwitchAdapter;
import io.krumbs.krumbscamera.camera.KCameraFrgment;

public class PostFormItemActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent intent = getIntent();
        String title = intent.getStringExtra(MainActivity.FROM_TITLE);

        setContentView(R.layout.activity_post_form_item);
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(true);
        }

        setTitle(title + getApplicationContext().getText(R.string.form_titlebar_additional_text));

        final View okButton = findViewById(R.id.check_form_submit);
        final View cancelButton = findViewById(R.id.check_form_cancel);
        okButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                NavUtils.navigateUpFromSameTask(PostFormItemActivity.this);
            }
        });
        cancelButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                NavUtils.navigateUpFromSameTask(PostFormItemActivity.this);
            }
        });

        ((ImageView)findViewById(R.id.form_title_icon)).setImageDrawable(
                new IconDrawable(this, FontAwesomeIcons.fa_pencil).colorRes(R.color.icon_color).sizeDp(12)
        );
        ((ImageView)findViewById(R.id.form_description_icon)).setImageDrawable(
                new IconDrawable(this, FontAwesomeIcons.fa_sticky_note).colorRes(R.color.icon_color).sizeDp(12)
        );


        FloatingActionButton fab = ((FloatingActionButton)findViewById(R.id.camera_button));
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                System.out.println("Start SDK Camera");
                FragmentTransaction ft =
                        getSupportFragmentManager().beginTransaction();
                ExpressionalIntent expressionalIntent = new ExpressionalIntent();
                ContextSwitchAdapter contextSwitchAdapter = new ContextSwitchAdapter(null, null, null);
                System.out.println("End SDK Camera");
                KCameraFrgment kCameraFrgment = new KCameraFrgment();
//                KCameraFrgment kCameraFrgment = new KCameraFrgment();
//                ft.add(R.id.fullscreen_content, kCameraFrgment);
            }

        });

    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);

    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == android.R.id.home) {
            // This ID represents the Home or Up button.
            NavUtils.navigateUpFromSameTask(this);
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

}
