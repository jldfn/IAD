package LabPack;

/**
 * Created by Another Denis on 25.10.2017.
 */
public class TableRow {
    private double x;
    private double y;
    private double r;
    private boolean res;

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public boolean isRes() {
        return res;
    }

    TableRow(double x, double y, double r, boolean res) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.res = res;
    }
}