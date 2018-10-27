with Ada.Text_IO; use Ada.Text_IO;

with VT100; use VT100;

with Game; use Game;

procedure Main is
    title : constant String := "Conway's Game of Life";

    nrows, ncolumns, nliving : Positive;
begin
    Reset;
    Set_Foreground_Color(Green);
    Put_Line(title);
    Set_Foreground_Color(Default);
    for it in title'Range loop
        Put("-");
    end loop;
    New_Line;
    Put("Number of rows: ");
    Set_Foreground_Color(Green);
    nrows := Positive'Value(Get_Line);
    Set_Foreground_Color(Default);
    Put("Number of columns: ");
    Set_Foreground_Color(Green);
    ncolumns := Positive'Value(Get_Line);
    Set_Foreground_Color(Default);
    Put("Number of initially living cells: ");
    Set_Foreground_Color(Green);
    nliving := Positive'Value(Get_Line);
    Set_Foreground_Color(Default);

    Init_Game(nrows, ncolumns, nliving);
    Print_Game_Field;
    delay 1.0;

    for it in 1 .. 100 loop
        Step_Game;
        Print_Game_Field;
        delay 0.5;
    end loop;
end Main;
