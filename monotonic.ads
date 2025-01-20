package Monotonic with SPARK_Mode is

   type Int_Array is array (Positive range <>) of Integer with
     Predicate => Int_Array'First = 1;
   type Cut_Points is array (Positive range <>) of Positive with
     Predicate => Cut_Points'First = 1;

   function Cut (S : Int_Array) return Cut_Points;

end Monotonic;
