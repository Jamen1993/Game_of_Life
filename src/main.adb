with VT100; use VT100;

with Game; use Game;

procedure Main is

begin
    Reset;
    Init_Game;
    Print_Game_Field;
    delay 1.0;

    for it in 1 .. 100 loop
        Step_Game;
        Print_Game_Field;
        delay 0.5;
    end loop;
end Main;
