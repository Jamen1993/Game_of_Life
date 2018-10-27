package Game is

    type Cell_State_t is (dead, alive);
    type Living_Neighbours_t is new Natural range 0 .. 8;
    
    type Game_Field_Index_t is new Positive;
    type Game_Field_t is array (Game_Field_Index_t range <>, Game_Field_Index_t range <>) of Cell_State_t;
    type Game_Field_Acc is access Game_Field_t;
    
    procedure Init_Game (sy, sx : in Positive; to_set : in Positive);
    procedure Print_Game_Field;
    procedure Step_Game;
    
private
    game_field : Game_Field_Acc;
    
    function Count_Neighbours (y, x : in Game_Field_Index_t) return Living_Neighbours_t;

end Game;
