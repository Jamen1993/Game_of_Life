package Game is

    type Cell_State_t is (dead, alive);
    type Living_Neighbours_t is new Natural range 0 .. 8;
    
    type Game_Field_Index_t is new Positive range 1 .. 50;
    type Game_Field_t is array (Game_Field_Index_t, Game_Field_Index_t) of Cell_State_t;
    
    procedure Init_Game;
    procedure Print_Game_Field;
    procedure Step_Game;
    
private
    game_field : Game_Field_t := (others => (others => dead));
    
    function Count_Neighbours (y, x : in Game_Field_Index_t) return Living_Neighbours_t;

end Game;
