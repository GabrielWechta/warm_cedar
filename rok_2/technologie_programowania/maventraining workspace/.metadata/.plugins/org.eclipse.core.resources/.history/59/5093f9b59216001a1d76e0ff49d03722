package Server;

import Exceptions.KoExeption;
import Exceptions.StoneAlreadyThereException;
import Exceptions.SuicidalTurnExeption;

import java.util.ArrayList;
import java.util.List;

public class Intersection {


    public void putToken(Player owner) throws StoneAlreadyThereException, KoExeption, SuicidalTurnExeption {
        if (getOwner() != null)
            throw new StoneAlreadyThereException();
        else if (isSuicidal(owner)) {
            throw new SuicidalTurnExeption();
        } else {
            owner.setWasInKo(false);
            List<Intersection> neighbors = getNotEmptyNeighbors();
            setOwner(owner);
            new StoneChain(this, owner);
            if (!neighbors.isEmpty()) {

                for (Intersection intersection : neighbors
                ) {
                    intersection.removeLiberti(this);
                    if (intersection.getOwner() != owner) {
                        intersection.tryToKill(owner);
                    } else {
                        this.stoneChain.merge(intersection.getStoneChain());
                    }

                }


                for (Intersection emptyIntersection : getEmptyNeighbors()
                ) {
                    stoneChain.addLiberti(emptyIntersection);
                }
            }
            if(getChainLibertiesCount()!=1)
            {owner.setWasInKo(false);}
        }
    }

    private void removeLiberti(Intersection intersection) {
        stoneChain.removeLiberti(intersection);
    }

    private void tryToKill(Player owner) {
        stoneChain.tryToKill(owner);
    }

    private final int x, y;
    private StoneChain stoneChain;
    private Player owner = null;
    private Board board;

    // regular constructor
    public Intersection(int x, int y, StoneChain stoneChain, Board board) {
        this.x = x;
        this.y = y;
        this.stoneChain = stoneChain;
    }

    public Intersection(int x, int y, Board board) {
        super();
        this.x = x;
        this.y = y;
        this.board = board;
    }

    public StoneChain getStoneChain() {
        return stoneChain;
    }

    public void setStoneChain(StoneChain stoneChain) {
        this.stoneChain = stoneChain;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public Player getOwner() {
        return owner;
    }


    public void setOwner(Player owner) {
        this.owner = owner;
    }

    public boolean isEmpty() {
        if (this.owner == null)
            return true;
        else
            return false;
    }

    public List<Intersection> getEmptyNeighbors() {
        List<Intersection> emptyNeighbors = new ArrayList<Intersection>();

        int xTable[] = {-1, 0, 1, 0};
        int yTable[] = {0, -1, 0, 1};
        int newX;
        int newY;
        for (int i = 0; i < xTable.length; i++) {
            newX = this.x + xTable[i];
            newY = this.y + yTable[i];

            if (board.isIn(newX, newY)) {
                Intersection sharedWallIntersection = board.getIntersection(newX, newY);

                if (sharedWallIntersection.isEmpty()) {

                    emptyNeighbors.add(sharedWallIntersection);

                }
            }
        }
        return emptyNeighbors;
    }

    public List<Intersection> getNotEmptyNeighbors() {
        List<Intersection> notEmptyNeighbors = new ArrayList<Intersection>();

        int xTable[] = {-1, 0, 1, 0};
        int yTable[] = {0, -1, 0, 1};
        int newX;
        int newY;
        for (int i = 0; i < xTable.length; i++) {
            newX = this.x + xTable[i];
            newY = this.y + yTable[i];

            if (board.isIn(newX, newY)) {
                Intersection sharedWallIntersection = board.getIntersection(newX, newY);

                if (!sharedWallIntersection.isEmpty()) {

                    notEmptyNeighbors.add(sharedWallIntersection);

                }
            }
        }
        return notEmptyNeighbors;
    }

    int getChainLibertiesCount() {
        return stoneChain.getLibertiesNumber();
    }

    boolean isSuicidal(Player player) throws KoExeption {
        boolean isKilling = false;
        boolean isSuicidal = getEmptyNeighbors().isEmpty();
        for (Intersection neighbor : getNotEmptyNeighbors()
        ) {
            if (neighbor.getChainLibertiesCount() == 1) {
                if (neighbor.getOwner() == player) {
                    isSuicidal = true;
                } else {
                    if (neighbor.getChainStonesCount() == 1) {
                        if (player.wasInKo()) {
                            throw new KoExeption();
                        }
                    }
                    isKilling = true;
                }
            }
        }

        return (!isKilling) && (isSuicidal);
    }

    int getChainStonesCount() {
        return stoneChain.getStoneNumber();
    }

    public void die() {
        setOwner(null);
        for (Intersection intersection : getNotEmptyNeighbors()
        ) {
            intersection.getStoneChain().addLiberti(this);
        }
        setStoneChain(null);
    }
}
