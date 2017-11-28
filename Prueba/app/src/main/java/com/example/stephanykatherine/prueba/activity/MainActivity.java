package com.example.stephanykatherine.prueba.activity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.ListView;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.stephanykatherine.prueba.R;
import com.example.stephanykatherine.prueba.adapter.AdapterUsuarios;
import com.example.stephanykatherine.prueba.controller.AppController;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Map;

import static android.R.id.list;

public class MainActivity extends AppCompatActivity {
    String[] direccionCompleta,nombreUsuarios;
    ListView list;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Tag used to cancel the request
        //String tag_json_obj = "json_obj_req";

        String url = "https://jsonplaceholder.typicode.com/users";
        verUsuarios(url);
        /*final ProgressDialog pDialog = new ProgressDialog(this);
        pDialog.setMessage("Loading...");
        pDialog.show();*/

        /*JsonObjectRequest jsonObjReq = new JsonObjectRequest(Request.Method.GET,
                url, null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d("TAGres", response.toString());
                        pDialog.hide();
                    }
                }, new Response.ErrorListener() {

            @Override
            public void onErrorResponse(VolleyError error) {
                VolleyLog.d("TAGe", "Error: " + error.getMessage());
                // hide the progress dialog
                pDialog.hide();
            }
        });

// Adding request to request queue
        AppController.getInstance().addToRequestQueue(jsonObjReq, tag_json_obj);*/


    }

    public void verUsuarios(String url){
        final RequestQueue queue = Volley.newRequestQueue(getApplicationContext());
        StringRequest post = new StringRequest(Request.Method.GET, url, new Response.Listener<String>() {

            @Override
            public void onResponse(String response) {
                try {

                    Log.d("TAG", "Login Response: " + response.toString());
                    JSONArray jsonArray = new JSONArray(response.toString());
                    if(jsonArray.length() !=0){
                        nombreUsuarios = new String[jsonArray.length()];
                        direccionCompleta = new String[jsonArray.length()];
                        for (int i=0; i < jsonArray.length(); i++)
                        {
                            JSONObject oneObject = jsonArray.getJSONObject(i);
                            String nombreUsuario = oneObject.getString("name");
                            JSONObject direccion = oneObject.getJSONObject("address");
                            String calle = direccion.getString("street");
                            String suite = direccion.getString("suite");
                            String city = direccion.getString("city");
                            nombreUsuarios[i] = nombreUsuario;
                            direccionCompleta[i] = calle + " " + suite + " - " + city;
                            oneObject.length();
                            //JsonMaterias = oneObject.getJSONArray("materias");
                        }
                        AdapterUsuarios adapter = new AdapterUsuarios(MainActivity.this,nombreUsuarios,direccionCompleta);//,imageProfesor);
                        list=(ListView)findViewById(R.id.listViewUsuarios);
                        list.setAdapter(adapter);
                    }
                    /*JsonAll = jsonObject.getJSONArray("result");
                    if(JsonAll.length()!=0){

                        for (int i=0; i < JsonAll.length(); i++)
                        {
                            JSONObject oneObject = JsonAll.getJSONObject(i);
                            oneObjectsItem = oneObject.getString("promedio");
                            promedioNotas.setText(oneObjectsItem);

                            double a  = Double.parseDouble(oneObjectsItem);
                            if(a<7.00){

                                promedioNotas.setTextColor(Color.RED);

                            }else{
                                promedioNotas.setTextColor(Color.BLACK);
                            }

                            JsonMaterias = oneObject.getJSONArray("materias");
                        }

                        final ArrayList<String> Keys = new ArrayList<String>();
                        for (int t = 0; t < JsonMaterias.length(); t++) {
                            Keys.add(String.valueOf(t));
                        }
                        materias = new String[Keys.size()];
                        alum_curs_para_mate_codi = new String[Keys.size()];
                        promedio = new String[Keys.size()];
                        matePadr = new String[Keys.size()];
                        numInsumos = new int[Keys.size()];
                        nota_refe_cab_codi = new int[Keys.size()];

                        for (int j=0; j < JsonMaterias.length(); j++)
                        {
                            JSONObject oneObject = JsonMaterias.getJSONObject(j);
                            materias[j] = oneObject.getString("nombre");
                            alum_curs_para_mate_codi[j] = oneObject.getString("alum_curs_para_mate_codi");
                            promedio[j] = oneObject.getString("prom");
                            matePadr[j] = oneObject.getString("mate_padr");
                            numInsumos[j] = oneObject.getInt("numInsumos");
                            nota_refe_cab_codi[j] = oneObject.getInt("nota_refe_cab_codi");

                            keys=oneObject.names();
                            values  = oneObject.toJSONArray(keys);
                        }

                        AdapterVerNotas adapter = new AdapterVerNotas(MostrarNotasGeneralActivity.this,materias,alum_curs_para_mate_codi,promedio,matePadr,numInsumos,nota_refe_cab_codi,colegio,periDistCodi);


                        expandableListView.setAdapter(adapter);
                    }*/

                } catch (Exception e)
                {
                    e.printStackTrace();
                    Log.d("facturaerror", e.toString());

                }
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d("TAGerror", error.toString());
            }
        }){
        };
        queue.add(post);
    }
}

