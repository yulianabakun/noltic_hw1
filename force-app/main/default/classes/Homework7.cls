/**
 * Created by Yulisha on 7/10/2022.
 */

public with sharing class Homework7 {
    public static void createHumans (){
        God god = new God();
        Man adam = god.createMan('Adam');

        Woman eve = god.createWoman('Eve');
    }
}