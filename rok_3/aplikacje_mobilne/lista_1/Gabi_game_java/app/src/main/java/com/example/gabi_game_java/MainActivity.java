package com.example.gabi_game_java;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Random;

public class MainActivity extends AppCompatActivity {
    private int product;
    private long startTime;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setOperationAndButtons();
    }

    private void setOperationAndButtons() {
        Random rand = new Random(System.currentTimeMillis());
        int multiplicand = rand.nextInt(10);
        int multiplier = rand.nextInt(10);
        product = multiplicand * multiplier;

        TextView operation = (TextView) findViewById(R.id.operation);
        operation.setText(Integer.toString(multiplicand) + "\t\u22C5\t" + Integer.toString(multiplier));

        Button button1 = (Button) findViewById(R.id.button);
        button1.setOnClickListener(this::onClick);
        button1.setText(Integer.toString(rand.nextInt(100)));

        Button button2 = (Button) findViewById(R.id.button2);
        button2.setOnClickListener(this::onClick);
        button2.setText(Integer.toString(rand.nextInt(100)));

        Button button3 = (Button) findViewById(R.id.button3);
        button3.setOnClickListener(this::onClick);
        button3.setText(Integer.toString(rand.nextInt(100)));

        Button button4 = (Button) findViewById(R.id.button4);
        button4.setOnClickListener(this::onClick);
        button4.setText(Integer.toString(rand.nextInt(100)));

        switch (rand.nextInt(4)) {
            case 0:
                button1.setText(Integer.toString(product));
            case 1:
                button2.setText(Integer.toString(product));
            case 2:
                button3.setText(Integer.toString(product));
            case 3:
                button4.setText(Integer.toString(product));
        }
        startTime = System.currentTimeMillis();
    }

    private void onClick(View v) {
        long difference = System.currentTimeMillis() - startTime;

        Button button = (Button) v;
        if (Integer.parseInt(button.getText().toString()) == product) {
            Toast.makeText(this, Long.toString(difference) + " ms", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(this, "No, Mister", Toast.LENGTH_SHORT).show();
        }
        setOperationAndButtons();
    }
}