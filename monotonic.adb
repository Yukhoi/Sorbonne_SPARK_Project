with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Monotonic with SPARK_Mode is

   function Cut (S : Int_Array) return Cut_Points is
      Cut : Cut_Points(1 .. S'Length + 1):= (others => 1 ); -- Pre-allocated array
      Last : Positive := 1; -- Tracks the number of elements in Cut
      X : Integer := 1;
      Y : Integer := 2;
      Increasing : Boolean;
   begin
      Cut(Last) := 1;
      while Y <= S'Length loop
          pragma Loop_Invariant(
               1 <= X and X < S'Length and 
               1 < Y and Y <= S'Length and
               1 <= Last and 
               Last < Cut'Length and
               X < Y and
               Last <= X and

               --Prop 2
               Cut(Cut'First) = 1 and Cut(Last) <= S'Length  and
               --Prop 3
               (for all I in 1..Last => 
                  1 <= Cut(I) and Cut(I) <= S'Length ) and
               --Prop 4
               Cut(Last) = X and
               (for all I in 1..Last-1 => (
                  for all J in I+1..Last => (
                     Cut(I) < Cut(J)
                  )
               )) --`and
               --Prop 5
               --(for all I in 1..Last-1 => (
               --   Croissant(S(Cut(I)..Cut(I+1))) or 
               --   Decroissant(S(Cut(I)..Cut(I+1)))
               --))
            );

           pragma Loop_Variant(Increases => Y);
            --  pragma Loop_Variant(Increases => Last);

         --  declare
         --     Increasing : Boolean;
         
            Increasing := S(X) < S(Y);
            while Y <= S'Length and (S(Y - 1) < S(Y)) = Increasing loop
               Y := Y + 1;
               if Y > S'Length then
                  exit;
               end if;
               
               pragma Loop_Variant (Increases => Y);
               pragma Loop_Invariant(
                  1 < Y and Y <= S'Length and Y >=Y'Loop_Entry
               );
            end loop;

            Last := Last + 1;
            Cut(Last) := Y;
        
            X := Y;
            Y := X + 1;
      end loop;

      if X <= S'Length then
         Last := Last + 1;
         Cut(Last) := S'Length + 1;
      end if;

      return Cut(1 .. Last);
   end Cut;

   --  procedure Print_Cut_Points(Cut : Cut_Points) is
   --  begin
   --     Put("Cut Points: (");
   --     for I in Cut'Range loop
   --        Put(Integer(Cut(I))); 
   --        if I /= Cut'Last then
   --           Put(", ");
   --        end if;
   --     end loop;
   --     Put_Line(")");
   --  end Print_Cut_Points;


end Monotonic;

