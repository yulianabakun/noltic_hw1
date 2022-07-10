/**
 * Created by Yulisha on 7/10/2022.
 */

public class God {
    public Man createMan(String name) {
        Man man = new Man (name);
        return man;
    }
    public Woman createWoman(String name) {
        Woman woman = new Woman (name);
        return woman;
    }
}