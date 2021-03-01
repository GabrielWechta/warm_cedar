package test;

import java.awt.Point;

import java.util.Random;

import javax.swing.JFrame;



class Rabbit implements Runnable {
	
	Point pos = new Point(0,0);
	String Name;
	SimulationMatrix GbRef;
	boolean isAlive = true;
	
	public Rabbit(String Name, SimulationMatrix Gb, Point startingPoint) {
		this.Name = Name;
		this.GbRef = Gb;
		this.pos = startingPoint;
		GbRef.GameMatrix[pos.x][pos.y] = 'R';
	}
	@Override
	public void run() {
		while (isAlive) {
			GbRef.doMoveRabbit(this);
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}	
		}
		System.out.println(Name + " +++UMARL+++");
	}
}

class Wolf implements Runnable {
	Point pos = new Point(0,0);
	String Name;
	SimulationMatrix GbRef;
	boolean isReady = true;
	
	public Wolf (String Name, SimulationMatrix Gb, Point startingPoint) {
		this.Name = Name;
		this.GbRef = Gb;
		this.pos = startingPoint;
		GbRef.GameMatrix[pos.x][pos.y] = 'W';
	}
	
	@Override
	public void run() {
		while (GbRef.RabbitCount != 0) {
			if(GbRef.wolfFlag) {
				GbRef.doMoveWolf(this);	
			}		
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}


public class SimulationMatrix extends JFrame{
	final static int ROW = 4;
	final static int COL = 4;
	char[][] GameMatrix = new char[ROW][COL];
	
	int cycleAfterDeathCount = 0;
	boolean wolfFlag = true;
	int RabbitCount = 2;
	
	int[] FirstCheckingTab =  {1, 1, 1, 0,-1,-1,-1, 0}; //ale possibilities of moving N,NE,E... 
	int[] SecondCheckingTab = {1, 0,-1,-1,-1, 0, 1, 1}; 
	
	Random rand = new Random();
	
	boolean isValid(int row, int col) {
		if((row >= 0) && (row < ROW) && (col >= 0) && (col < COL)) return true;
		else return false;														// do zmiany
	}
	
	synchronized void doMoveRabbit(Rabbit r) {
		cycleAfterDeathCount++;
		if(GameMatrix[r.pos.x][r.pos.y] == 'W') {
			r.isAlive = false;
			wolfFlag = false;
			cycleAfterDeathCount = 0;
			return;
		}
		
		if(cycleAfterDeathCount >=6 ) {
			wolfFlag = true;
			cycleAfterDeathCount = 0;
		}
		
		System.out.println("cycleAfterDeathCount = " + cycleAfterDeathCount);
		int index = rand.nextInt(8);
		
		for(int i = 0 ; i < 8 ; i++) {
			index = (index+1)%8;
			int row = r.pos.x + FirstCheckingTab[index];
			int col = r.pos.y + SecondCheckingTab[index];
			
			if(isValid(row,col) && GameMatrix[row][col] == '0') {
				GameMatrix[r.pos.x][r.pos.y] = '0';
				r.pos.x = row;
				r.pos.y = col;
				GameMatrix[r.pos.x][r.pos.y] = 'R';
				break;
			}
		}
		
		printGameMatrix();

	}
	
	synchronized void doMoveWolf(Wolf w) {
		w.isReady = true;
		int index = rand.nextInt(8);
		
		for(int i = 0 ; i < 8 ; i++) {
			index = (index+1)%8;
			int row = w.pos.x + FirstCheckingTab[index];
			int col = w.pos.y + SecondCheckingTab[index];
			
			if(isValid(row,col)) {

				GameMatrix[w.pos.x][w.pos.y] = '0';
				w.pos.x = row;
				w.pos.y = col;
				GameMatrix[w.pos.x][w.pos.y] = 'W';
				break;
			}
		}
		
		printGameMatrix(); 
	}
	
	void printGameMatrix() {
		for(int i = 0; i < ROW; i++) {
			for(int j = 0 ; j < COL; j++ ) {
				System.out.print(GameMatrix[i][j] + " ");
			}
			System.out.println();
		}
		System.out.println();
	}
}
