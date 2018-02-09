with Ada.Real_Time; use Ada.Real_Time;

package body Game is

   protected body Protected_Game_Field_t is
      procedure set_all (new_field : in Game_Field_t) is
      begin
         game_field := new_field;
      end set_all;

      procedure set_cell_state (x, y : in Game_Field_Index_t; new_state : in Cell_State_t) is
      begin
         game_field (x, y) := new_state;
      end set_cell_state;

      function get_all return Game_Field_t is
      begin
         return game_field;
      end get_all;

      function get_cell_state (x, y : in Game_Field_Index_t) return Cell_State_t is
      begin
         return game_field (x, y);
      end get_cell_state;

   end Protected_Game_Field_t;

   task body Game_Task is
      TASK_PERIOD : constant Time_Span := Milliseconds (100);
      next_time : Time := Clock;
   begin
      null;

      next_time := next_time + TASK_PERIOD;
      delay until next_time;
   end Game_Task;

   procedure determine_new_cell_states is
      new_game_field : Game_Field_t;
      living_neighbours : Living_Neighbours_t;
   begin
      for x in new_game_field'Range(1) loop
         for y in new_game_field'Range(2) loop
            living_neighbours := count_living_neighbours (x, y);

            if living_neighbours = 3 then
               new_game_field (x, y) := alive;
            elsif living_neighbours < 2 then
               new_game_field (x, y) := dead;
            elsif living_neighbours > 3 then
               new_game_field (x, y) := dead;
            else
               new_game_field (x, y) := game_field.get_cell_state (x, y);
            end if;
         end loop;
      end loop;
   end determine_new_cell_states;

   function count_living_neighbours (x, y : in Game_Field_Index_t) return Living_Neighbours_t is
   begin
      return 0;
   end count_living_neighbours;

end Game;
