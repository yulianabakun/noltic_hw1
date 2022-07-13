/**
 * Created by Yulisha on 7/13/2022.
 */
public class Homework8 {
    public static void testFight() {
        Fighter fighter1 = new Fighter('Elma', 100, 15);
        Fighter fighter2 = new Fighter('Yuliana', 100, 20);

        String winnerName = fight(fighter1, fighter2);
        System.debug('the winner is ' + winnerName);
    }
    public static String fight (Fighter fighter1, Fighter fighter2){

        while(fighter1.health>0 && fighter2.health>0){
            fighter2.health = fighter2.health - fighter1.damagePerAttack;
            fighter1.health = fighter1.health - fighter2.damagePerAttack;
        }
        if(fighter1.health>0){
            return fighter1.name;
        } else {
            return fighter2.name;
        }
    }
}