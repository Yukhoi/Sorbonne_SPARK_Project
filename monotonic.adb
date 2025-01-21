with Ada.Text_IO;
package body Monotonic with SPARK_Mode is

   function Cut (S : Int_Array) return Cut_Points is
      -- 定义变量
      Cut : Cut_Points (1 .. S'Length + 1); -- 初始化切点数组，大小为输入数组长度 + 1
      Last : Positive := 1;  -- 当前 Cut 数组的最后一个位置
      X : Positive := 1;    -- 当前段的起始位置
      Y : Positive := 2;    -- 当前段的检查位置
      Increasing : Boolean; -- 当前段是否递增
      IsLastAndMonotonic : Boolean := False; -- 是否为最后一个元素
   begin
      -- 如果输入数组为空，直接返回空切点数组
      if S'Length = 0 then
         return Cut(1 .. 1);
      end if;

      -- 初始化 Cut 数组，首个切点为 1
      Cut(Last) := 1;

      -- 遍历序列，直到检查完整个数组
      while Y <= S'Length loop
         -- 确定当前段是否递增
         Increasing := S(X) < S(Y);

         -- 检查当前段的单调性
         while Y < S'Length and then (S(Y - 1) < S(Y)) = Increasing loop
            Y := Y + 1;
         end loop;

         if (Y = S'Length and (S(Y - 1) < S(Y)) = Increasing) then
            IsLastAndMonotonic := True;
         end if;



          -- 打印当前检查位置 Y
          Ada.Text_IO.Put_Line("Y = " & Integer'Image(Y));

         -- 当前段结束，添加切点
         Last := Last + 1;
          if IsLastAndMonotonic then
            Cut(Last) := Y + 1;
          else
            Cut(Last) := Y;
          end if;

         -- 更新起始位置和检查位置
         X := Y;
         Y := X + 1;
      end loop;

      if not IsLastAndMonotonic then
         -- 最后一个元素不在最后一个段内，添加最后一个切点
         Last := Last + 1;
         Cut(Last) := S'Length + 1;
      end if;


      -- 返回有效的 Cut 数组（从 1 到 Last）
      for I in Cut'Range loop
         Ada.Text_IO.Put_Line("Cut(" & Integer'Image(I) & ") = " & Integer'Image(Cut(I)));
      end loop;
      return Cut(1 .. Last);
   end Cut;

end Monotonic;
