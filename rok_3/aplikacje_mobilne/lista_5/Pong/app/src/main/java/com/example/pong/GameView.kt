package com.example.pong

import android.app.Activity
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.SurfaceHolder
import android.view.SurfaceView
import com.example.pong.data.Point
import com.example.pong.data.PointViewModel
import java.time.LocalDate
import kotlin.math.abs
import kotlin.random.Random

class Player(x: Float = -1f, y: Float = -1f) {
    var x = x
    var y = y
    var score = 0
}

class GameView(context: Context, attributeSet: AttributeSet?, private val model: PointViewModel) :
    SurfaceView(context, attributeSet), SurfaceHolder.Callback {

    private val thread: GameThread
    private var ballX = -1f
    private var ballY = -1f
    private var dx = 0f
    private var dy = 25f
    private val BALL_SIZE = 50f
    private val PALETTE_SIZE = 150f
    private var southPlayer = Player()
    private var northPlayer = Player()

    private val ballPaint = Paint().apply {
        color = Color.WHITE
    }

    private val palettePaintN = Paint().apply {
        color = Color.WHITE
    }

    private val palettePaintS = Paint().apply {
        color = Color.WHITE
    }

    private val textPaint = Paint().apply {
        textAlign = Paint.Align.CENTER
        color = Color.parseColor("#4d002d")
        textSize = 100f
    }

    init {
        holder.addCallback(this)
        thread = GameThread(holder, this)
    }

    override fun surfaceCreated(holder: SurfaceHolder) {
        thread.running = true
        thread.start()
    }

    override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
    }

    override fun surfaceDestroyed(holder: SurfaceHolder) {
        thread.running = false
        thread.join()
    }

    override fun draw(canvas: Canvas?) {
        super.draw(canvas)
        if (canvas == null) return

        // happens only once
        if (ballX == -1f && ballY == -1f) {
            restartBall()
            southPlayer.x = width / 2f
            southPlayer.y = height - (height / 20f)
            northPlayer.x = width / 2f
            northPlayer.y = height / 20f
        }

        canvas.drawText(
            "N: ${northPlayer.score} / S: ${southPlayer.score}",
            width / 2f,
            height / 2 - (textPaint.descent() + textPaint.ascent()) / 2f,
            textPaint
        )


        canvas.drawOval(ballX, ballY, ballX + BALL_SIZE, ballY + BALL_SIZE, ballPaint)
        canvas.drawRect(
            northPlayer.x - PALETTE_SIZE,
            northPlayer.y + 15f,
            northPlayer.x + PALETTE_SIZE,
            northPlayer.y - 15f,
            palettePaintN
        )
        canvas.drawRect(
            southPlayer.x - PALETTE_SIZE,
            southPlayer.y + 15f,
            southPlayer.x + PALETTE_SIZE,
            southPlayer.y - 15f,
            palettePaintS
        )

        palettePaintN.color = Color.WHITE
        palettePaintS.color = Color.WHITE
    }

    fun update() {
        ballX += dx
        ballY += dy

        if (ballX <= 0 || ballX + BALL_SIZE >= width) {
            dx = -dx
        }

        if (abs(ballY - northPlayer.y) <= abs(dy) && ballX in (northPlayer.x - PALETTE_SIZE..northPlayer.x + PALETTE_SIZE)) {
            dy = -dy
            palettePaintN.color = Color.parseColor("#d8d8d8")
        }
        if (abs(ballY - southPlayer.y) - dy <= abs(dy) && ballX in (southPlayer.x - PALETTE_SIZE..southPlayer.x + PALETTE_SIZE)) {
            dy = -dy
            palettePaintS.color = Color.parseColor("#d8d8d8")
        }

        if (ballY <= 0) {
            northPlayer.score += 1
            model.insert(Point("N", LocalDate.now()))
            restartBall()
        }

        if (ballY + BALL_SIZE >= height) {
            southPlayer.score += 1
            model.insert(Point("S", LocalDate.now()))
            restartBall()
        }
    }

    override fun onTouchEvent(event: MotionEvent?): Boolean {
        if (event != null) {
            if (event.y > height / 2) {
                southPlayer.x = event.x
            }
            if (event.y < height / 2) {
                northPlayer.x = event.x
            }
        }

        return true
    }

    private fun restartBall() {
        initializeBallSpeed()
        ballX = (width.toFloat() - BALL_SIZE) / 2f
        ballY = (height.toFloat() - BALL_SIZE) / 2f
    }

    private fun initializeBallSpeed() {
        var initial = Random.nextFloat()
        dy = 1f - initial
        if (dy < 0.3f) {
            dy = 0.3f
        }
        dx = 50 * initial
        dy *= 50
    }
}