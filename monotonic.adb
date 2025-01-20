package body Monotonic with SPARK_Mode is

   function Cut (S : Int_Array) return Cut_Points is
      -- 定义变量
      Cut : Cut_Points (1 .. S'Length + 1);
      Last : Positive := 1;  -- 当前 Cut 数组的最后一个位置
      X : Positive := 1;    -- 当前段的起始位置
      Y : Positive := 2;    -- 当前段的检查位置
      Increasing : Boolean; -- 当前段是否递增
   begin
      -- 初始化 Cut 数组，首个切点为 1
      Cut(Last) := 1;

      -- 遍历序列，直到检查完整个数组
      while Y <= S'Length loop
         -- 确定当前段是否递增
         Increasing := S(X) < S(Y);

         -- 检查当前段的单调性
         while Y <= S'Length and (S(Y - 1) < S(Y)) = Increasing loop
            Y := Y + 1;
         end loop;

         -- 当前段结束，添加切点
         Last := Last + 1;
         Cut(Last) := Y;

         -- 更新起始位置和检查位置
         X := Y;
         Y := X + 1;
      end loop;

      -- 如果最后一个位置未被覆盖，添加 n+1 为最后的切点
      if X <= S'Length then
         Last := Last + 1;
         Cut(Last) := S'Length + 1;
      end if;

      -- 返回有效的 Cut 数组（从 1 到 Last）
      return Cut(1 .. Last);
   end Cut;

end Monotonic;

