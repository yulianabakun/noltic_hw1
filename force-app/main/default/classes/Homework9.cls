public with sharing class Homework9 {

    public static Set<Integer> getUnique (List<Integer> numbers){
        Set<Integer> uniqueValues = new Set<Integer>(numbers);

        return uniqueValues;
    }

    public static Contact getContactByName (String name, List<Contact> contacts){
        Contact result;
        for (Contact contact : contacts) {
            if(contact.Name == name){
                result = contact;
                break;
            }
        }
        return result;


    }
    public static Opportunity getLargestOpp (Decimal ammount, List<Opportunity> opps){
        Decimal largestAmount =-1;
        Opportunity largestOpp;
        for (Opportunity opp : opps) {
            if(opp.Amount > largestAmount){
                largestAmount = opp.Amount;
                largestOpp = opp;
            }
        }
        return largestOpp;
    }

    public static List<Integer> getDigits (Integer num){
        List<Integer> result = new List<Integer>();
        while( num > 0){
            Integer digit = Math.mod(num, 10);
            if(result.isEmpty()){
                result.add(digit);
            } else{
                result.add(0, digit);
            }
            num = num/10;
        }
        return result;
    }

    public class Stack {
        private List<Integer> arr = new List<Integer>();

        public void put(Integer num) {
            arr.add(num);
        }
        public Integer pop() {
            Integer removedItem = arr.remove(arr.size() - 1);

            return removedItem;
        }
    }

    public class Queue {
        private List<Integer> arr = new List<Integer>();

        public void put(Integer num) {
            arr.add(num);
        }
        public Integer pop() {
            Integer removedItem = arr.remove(0);

            return removedItem;
        }
    }
}