package Server;

import Exceptions.KoExeption;
import Exceptions.OutOfBoardsBoundsException;
import Exceptions.StoneAlreadyThereException;
import Exceptions.SuicidalTurnExeption;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class StoneChainTest {
    Board board;
    Player f;
    Player s;

    @org.junit.jupiter.api.BeforeEach
    void setUp() {
        board = new Board(6);

        board.showBoard();

        f = new Player(1, board);
        s = new Player(2, board);


    }


    @Test
    void getOwner() {
    }

    @Test
    void killTest() throws SuicidalTurnExeption, KoExeption, OutOfBoardsBoundsException, StoneAlreadyThereException {
        f.playStone(0,0);
        s.playStone(1,0);
        s.playStone(0,1);
        board.showBoard();
        assertTrue(board.getIntersection(0,0).getOwner()==null);



    }
    @Test
    void koTest() throws SuicidalTurnExeption, KoExeption, OutOfBoardsBoundsException, StoneAlreadyThereException {

        f.playStone(1,0);
        f.playStone(0,1);
        f.playStone(1,2);
        s.playStone(3,1);
        s.playStone(2,0);
        s.playStone(2,2);
        board.showBoard();
        s.playStone(1,1);
        board.showBoard();
        f.playStone(2,1);

        board.showBoard();
        s.playStone(1,1);
        assertTrue(s.wasInKo());
        board.showBoard();
        f.playStone(2,1);
    }

    @Test
    void getStones() {
    }
}