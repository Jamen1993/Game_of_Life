package Game is

   type Cell_State_t is (dead, alive);
   type Game_Field_Index_t is new Positive range 1 .. 100;
   type Game_Field_t is array (Game_Field_Index_t, Game_Field_Index_t) of Cell_State_t;

   type Living_Neighbours_t is new Natural range 0 .. 8;

   protected type Protected_Game_Field_t is
      procedure set_all (new_field : in Game_Field_t);
      procedure set_cell_state (x, y : in Game_Field_Index_t; new_state : in Cell_State_t);

      function get_all return Game_Field_t;
      function get_cell_state (x, y : in Game_Field_Index_t) return Cell_State_t;
   private
      game_field : Game_Field_t := (others => (others => dead));
   end Protected_Game_Field_t;

   game_field : Protected_Game_Field_t;

private
   procedure determine_new_cell_states;
   function count_living_neighbours (x, y : in Game_Field_Index_t) return Living_Neighbours_t;

   task Game_Task;


end Game;
