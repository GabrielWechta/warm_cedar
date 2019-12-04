package GameMaster;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import Exceptions.KoExeption;
import Exceptions.OutOfBoardsBoundsException;
import Exceptions.StoneAlreadyThereException;
import Exceptions.SuicidalTurnExeption;
import Server.Board;
import Server.Player;

public class Mediator {
	private Player playerB;
	private Player playerW;
	private Board board;
	private char turn = 'B';

	/** used when we are ready to start the game */
	public Mediator(Player playerB, Player playerW, Board board) { 
		this.playerB = playerB;
		this.playerW = playerW;
		this.board = board;
	}

	/** if put insight while() should start only after everybody connects */
	public boolean ifReadyStart() {
		if (playerB != null && playerW != null && board != null) {
			start();
			return true;
		}
		return false;
	}
	
	/** private method helper in start()*/
	private int getXFromInput(String input) {
		try {
			int x = Integer.parseInt(input.subSequence(0, input.indexOf(';')).toString());
			System.out.println(x);
			return x;
		} catch (NumberFormatException e) {
			System.out.println("Incorrect x input, please type again:");
		}
		return -1;
	}
	
	/** private method helper in start()*/
	private int getYFromInput(String input) {
		try {
			int y = Integer.parseInt(input.subSequence(input.indexOf(';') + 1, input.length()).toString());
			System.out.println(y);
			return y;
		} catch (NumberFormatException e) {
			System.out.println("Incorrect y input, please type again:");
		}
		return -1;
	}
	
	/** to be filled*/
	public boolean makeMoveIfVaild(int x, int y, Player player) {
		if (board.isIn(x, y) /* pozostale checkery czy mozna zrobic ruch) */) {
			try {
				board.playStone(x, y, player);
			} catch (StoneAlreadyThereException e) {
				e.printStackTrace();
			} catch (KoExeption koExeption) {
				koExeption.printStackTrace();
			} catch (SuicidalTurnExeption suicidalTurnExeption) {
				suicidalTurnExeption.printStackTrace();
			} catch (OutOfBoardsBoundsException e) {
				e.printStackTrace();
			}
			return true;
		} else
			return false;
	}
	
	/** main class method responsible for "keeping game on" until both players agree to pass*/
	public void start() {
		String input = new String();
		boolean stop = false;
		boolean oneWantsStop = false;

		BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

		while (stop == false) {
			board.showBoard();

			switch (turn) {
			case 'B':
				System.out.println("Black: ");

				try {
					input = reader.readLine();
				} catch (IOException e) {
					e.printStackTrace();
				}

				if (input.equals("pass")) {
					System.out.println("Black is passing");
					if (oneWantsStop == true) {
						stop = true;
						break;
					} else {
						oneWantsStop = true;
						turn = 'W';
						break;
					}
				} else {
					turn = 'W';
					int x = getXFromInput(input);
					int y = getYFromInput(input);
					if (x == -1 || y == -1){
						turn = 'B';
						break;
					}
					if (makeMoveIfVaild(x, y, playerB) == false){
						turn = 'B';
						break;
					}
					oneWantsStop = false;
				}
				break;

			case 'W':
				System.out.println("White: ");
				try {
					input = reader.readLine();
				} catch (IOException e) {
					e.printStackTrace();
				}
				if (input.equals("pass")) {
					System.out.println("White is passing");
					if (oneWantsStop == true) {
						stop = true;
						break;
					} else {
						oneWantsStop = true;
						turn = 'B';
						break;
					}
				} else {
					turn = 'B';
					int x = getXFromInput(input);
					int y = getYFromInput(input);
					if (x == -1 || y == -1) {
						turn = 'W';
						break;
					}
					if (makeMoveIfVaild(x, y, playerW) == false) {
						turn = 'W';
						break;
					}
					oneWantsStop = false;
				}
				break;

			default:
				System.out.println("Error in case in Mediator");
			}
		}
		System.out.println("+++GAME ENDED+++");

	}
}
