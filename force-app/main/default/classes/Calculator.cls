public with sharing class Calculator {
    @TestVisible
    Integer result;
    
    public Calculator()
    {
        result = 0;
    }
    
	Public integer add(integer x, integer y)
    {
        if((long)x + (long)y > 2147483647){
            return 0;
        }
        result = x + y;
        return result;
    }
    
    Public integer sub(integer x, integer y)
    {
        if(x>=y){
            result = x - y;
        }
        else{
            result = y - x;
                }
        return result;
    }
    
    Public integer multi(integer x, integer y)
    {
        result = x * y;
        return  result;
    }
    
    Public integer div(integer x, integer y)
    {
        if(x == 0 || y == 0){
            result = 0;
        }
        else{
            result = x / y;
        }

        return result;
    }
    
    @testVisible
    integer randomUpdateResult()
    {
        result = (integer)(Math.random()*result);
        return result;
    }
}