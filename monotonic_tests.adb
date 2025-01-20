with Monotonic; use Monotonic;
with Ada.Text_IO;

procedure Monotonic_Tests is
   A : constant Int_Array := (1, 2, 3, 4, 5);
   B : constant Int_Array := (1, 4, 7, 3, 2, 1, 5, 7);
   C : constant Int_Array := (6, 3, 4, 2, 5, 3, 7);
begin
   if Cut (A) = (1, 6) then
      Ada.Text_IO.Put_Line ("Test A: PASS");
   else
      Ada.Text_IO.Put_Line ("Test A: FAIL");
   end if;

   if Cut (B) = (1, 4, 7, 9) then
      Ada.Text_IO.Put_Line ("Test B: PASS");
   else
      Ada.Text_IO.Put_Line ("Test B: FAIL");
   end if;

   if Cut (C) = (1, 3, 5, 7, 8) then
      Ada.Text_IO.Put_Line ("Test C: PASS");
   else
      Ada.Text_IO.Put_Line ("Test C: FAIL");
   end if;
end Monotonic_Tests;
