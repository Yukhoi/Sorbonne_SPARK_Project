package Monotonic with SPARK_Mode is

   type Int_Array is array (Positive range <>) of Integer with
     Predicate => Int_Array'First = 1;
   type Cut_Points is array (Positive range <>) of Positive with
     Predicate => Cut_Points'First = 1;

   function Cut (S : Int_Array) return Cut_Points
   with
   Pre => S'First = 1 and S'Last < Positive'Last - 1,
   Post =>  --Prop 1
            Cut'Result'Length > 0 and
            --Prop 2
            Cut'Result(Cut'Result'First) = 1 and 
            Cut'Result(Cut'Result'Last) = S'Length + 1  and
            --Prop 3
            (for all I in Cut'Result'Range => (
                  1 <= Cut'Result(I) and Cut'Result(I) <= S'Length + 1 )
            ) and
            --Prop 4
            (for all I in 1..Cut'Result'Last-1 => (
               for all J in I+1..Cut'Result'Last => (
                  Cut'Result(I) < Cut'Result(J)
               )
            )) 
            
   ;

   procedure Print_Cut_Points(Cut : Cut_Points);

   function Croissant(S : Int_Array) return Boolean is
   (  if S'Length <= 1 then True
      else
      (for all I in 1..S'Last-1 => (
         for all J in I+1..S'Last =>(
            S(I) < S(J)
         ))
   ))
   with Ghost;

   function Decroissant(S : Int_Array) return Boolean is
   (  if S'Length <= 1 then True
      else
      (for all I in 1..S'Last-1 => (
         for all J in I+1..S'Last =>(
            S(I) > S(J)
         )  
      )
   ))
   with Ghost;


end Monotonic;
