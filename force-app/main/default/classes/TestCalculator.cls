@isTest
private class TestCalculator {

    static void randomResult()
    {
        Calculator c = new Calculator();
        
        integer a = c.result;
        integer b = c.randomUpdateResult();
    }
    
@isTest
    static void testAdd()
    {
        Calculator c = new Calculator();
        
        integer r = c.add(4,5);
        system.assertEquals(9,r,'Not working properly for +ve values');
        
        r = c.add(-4,-5);
        system.assertEquals(-9,r,'both -ve test');
        
        r = c.add(0,-5);
        system.assertEquals(-5,r,'-ve and zero test');
        
        r = c.add(2147483647,1);
        system.assertEquals(0,r, ' Out Of Range test');
    }
    
    
    @isTest
    static void testSub()
    {
        Calculator c = new Calculator();
        
        integer r = c.sub(10,5);
        system.assertEquals(5,r,'Not working properly for +ve values');
        
        r = c.sub(-4,-4);
        system.assertEquals(0,r,'both -ve test');
        
        r = c.add(3,5);
        system.assertEquals(8,r,'operand greater than the other test');
    }
    
    
    @isTest
    static void testMulti()
    {
        Calculator c = new Calculator();
        
        integer r = c.multi(10,5);
        system.assertEquals(50,r,'Not working properly for +ve values');
        
        r = c.multi(-4,-4);
        system.assertEquals(16,r,'both -ve test');
        
        r = c.multi(3,-5);
        system.assertEquals(-15,r,'one -ve test');
        
        r = c.multi(2,0);
        system.assertEquals(0,r, ' One 0 test');
    }
    
    
    
    @isTest
    static void testDiv()
    {
        Calculator c = new Calculator();
        
        integer r = c.div(10,5);
        system.assertEquals(2,r,'Not working properly for +ve values');
        
        r = c.div(-4,-4);
        system.assertEquals(1,r,'both -ve test');
        
        r = c.div(3,5);
        system.assertEquals(0,r,'zero test');
        
        r = c.div(-4,4);
        system.assertEquals(-1,r, ' One -ve test');
        
        r = c.div(4,-4);
        system.assertEquals(-1,r, ' One -ve test');
        
        r = c.div(2,0);
        system.assertEquals(0,r, ' One 0 test');
    }
}