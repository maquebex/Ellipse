package io.krumbs.sdk.starter;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Typeface;
import android.net.Uri;
import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by phani on 3/14/16.
 */

public class RVAdapter extends RecyclerView.Adapter<RVAdapter.EventViewHolder>{
    ArrayList<Event> data;
    private Activity mainActivity;

    public static class EventViewHolder extends RecyclerView.ViewHolder {
        CardView cv;
        TextView eventName;
        TextView eventDescription;

        EventViewHolder(View itemView) {
            super(itemView);
            cv = (CardView)itemView.findViewById(R.id.cv);
            eventName = (TextView)itemView.findViewById(R.id.event_name);
            eventName.setTextSize(18);
            eventName.setTypeface(null, Typeface.BOLD);
            eventDescription = (TextView)itemView.findViewById(R.id.event_description);
            eventDescription.setEllipsize(TextUtils.TruncateAt.END);
            eventDescription.setMaxLines(5);
        }
    }

    RVAdapter(Activity activity,ArrayList<Event> events){
        this.data = events;
        mainActivity = activity;
    }

    @Override
    public int getItemCount() {
        return data.size();
    }

    @Override
    public EventViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View v = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.card_item, viewGroup, false);
        EventViewHolder pvh = new EventViewHolder(v);
        return pvh;
    }

    @Override
    public void onBindViewHolder(EventViewHolder eventViewHolder, int i) {
        eventViewHolder.eventName.setText(data.get(i).title);
        eventViewHolder.eventDescription.setText(data.get(i).description);
        final int index = i;
        eventViewHolder.cv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(data.get(index).url));
                mainActivity.startActivity(browserIntent);
            }
        });

    }

    @Override
    public void onAttachedToRecyclerView(RecyclerView recyclerView) {
        super.onAttachedToRecyclerView(recyclerView);
    }

}