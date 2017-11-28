package com.example.stephanykatherine.prueba.adapter;

import android.app.Activity;
import android.graphics.Color;
import android.preference.PreferenceManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.example.stephanykatherine.prueba.R;

/**
 * Created by StephanyKatherine on 27/11/2017.
 */

public class AdapterUsuarios extends ArrayAdapter<String> {

    private final Activity context;
    private final String[] nombres;
    private final String[] direcciones;

    public AdapterUsuarios(Activity context, String[] nombres, String[] direcciones) {
        super(context, R.layout.lista_usuarios, nombres);
        this.context = context;
        this.nombres = nombres;
        this.direcciones = direcciones;
    }

    @Override
    public View getView(int position, View view, ViewGroup parent) {
        LayoutInflater inflater = context.getLayoutInflater();
        View rowView = inflater.inflate(R.layout.lista_usuarios, null, true);
        TextView txtNombre = (TextView) rowView.findViewById(R.id.nombreUsuario);
        TextView txtDireccion = (TextView) rowView.findViewById(R.id.direccionUsuario);

        txtNombre.setText(nombres[position]);
        txtDireccion.setText(direcciones[position]);

        if (position % 2 == 1) {
            rowView.setBackgroundColor(Color.parseColor("#e6e7e8"));
        } else {
            rowView.setBackgroundColor(Color.parseColor("#FFFFFFFF"));
            //rowView.setAlpha(0.2f);
        }

        return rowView;
    }
}