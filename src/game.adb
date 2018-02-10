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

   protected body Game_Control_t is
      procedure set_task_period (new_task_period : in Time_Span) is
      begin
         task_period := new_task_period;
      end set_task_period;

      procedure set_autoprogression_active (new_state : in Boolean) is
      begin
         autoprogression_active := new_state;
      end set_autoprogression_active;

      procedure set_next_step_single is
      begin
         next_step_single := True;
      end set_next_step_single;

      function get_task_period return Time_Span is
      begin
         return task_period;
      end get_task_period;

      function is_autoprogression_active return Boolean is
      begin
         return autoprogression_active;
      end is_autoprogression_active;

      procedure is_next_step_single (result : out Boolean) is
      begin
         if next_step_single then
            result := True;
            next_step_single := False;
         else
            result := False;
         end if;
      end is_next_step_single;
   end Game_Control_t;

   task body Game_Task is
      next_time : Time := Clock;

      execute_step : Boolean;
   begin
      loop
         game_control.is_next_step_single (execute_step);
         execute_step := execute_step or game_control.is_autoprogression_active;

         if execute_step then
            determine_new_cell_states;
         end if;

         next_time := next_time + game_control.get_task_period;
         delay until next_time;
      end loop;
   end Game_Task;

   procedure determine_new_cell_states is
      new_game_field : Game_Field_t;
      living_neighbours : Living_Neighbours_t;
   begin
      for it_x in new_game_field'Range (1) loop
         for it_y in new_game_field'Range (2) loop
            living_neighbours := count_living_neighbours (it_x, it_y);

            if living_neighbours = 3 then
               new_game_field (it_x, it_y) := alive;
            elsif living_neighbours < 2 then
               new_game_field (it_x, it_y) := dead;
            elsif living_neighbours > 3 then
               new_game_field (it_x, it_y) := dead;
            else
               new_game_field (it_x, it_y) := game_field.get_cell_state (it_x, it_y);
            end if;
         end loop;
      end loop;

      game_field.set_all (new_game_field);
   end determine_new_cell_states;

   function count_living_neighbours (x, y : in Game_Field_Index_t) return Living_Neighbours_t is
      living_neighbours : Living_Neighbours_t := 0;

      x_to_test, y_to_test : Positive;
   begin
      for x_deviation in Integer range -1 .. 1 loop
         for y_deviation in Integer range -1 .. 1 loop
            --  Skip the targeted cell itself
            if not (x_deviation = 0 and y_deviation = 0) then
               x_to_test := (x + x_deviation + Game_Field_Index_t'Last) mod Game_Field_Index_t'Last;
               y_to_test := (y + y_deviation + Game_Field_Index_t'Last) mod Game_Field_Index_t'Last;

               case game_field.get_cell_state (x_to_test, y_to_test) is
                  when alive => living_neighbours := living_neighbours + 1;
                  when dead => null;
               end case;
            end if;
         end loop;
      end loop;

      return living_neighbours;

   end count_living_neighbours;

end Game;
