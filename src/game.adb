with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

with VT100; use VT100;

package body Game is

    procedure Init_Game (to_set : in Positive) is
        package Rand is new Ada.Numerics.Discrete_Random(Result_Subtype => Game_Field_Index_t);
        generator : Rand.Generator;

        set : Natural := 0;
        x, y : Game_Field_Index_t;
    begin
        while set < to_set loop
            x := Rand.Random(generator);
            y := Rand.Random(generator);

            if game_field(y, x) = dead then
                game_field(y, x) := alive;
                set := set + 1;
            end if;
        end loop;
    end Init_Game;

    procedure Print_Game_Field is
        title : constant String := "Conways Game of Life";
    begin
        Clear_Screen;
        -- Print title
        Set_Foreground_Color(Green);
        Put_Line(title);
        Set_Foreground_Color(Default);
        for it in title'Range loop
            Put("-");
        end loop;
        New_Line;
        -- Print cells
        for ity in game_field'Range(1) loop
            for itx in game_field'Range(2) loop
                case game_field(ity, itx) is
                    when dead =>
                        Set_Foreground_Color(Red);
                        Put("X");
                    when alive =>
                        Set_Foreground_Color(Green);
                        Put("O");
                end case;
                Set_Foreground_Color(Default);
                Put(" ");
            end loop;
            New_Line;
        end loop;
        Set_Background_Color(Default);
    end Print_Game_Field;

    procedure Step_Game is
        new_game_field    : Game_Field_t := game_field;
        living_neighbours : Living_Neighbours_t;
    begin
        for ity in game_field'Range(1) loop
            for itx in game_field'Range(2) loop
                living_neighbours := Count_Neighbours(ity, itx);

                if living_neighbours <= 1 or living_neighbours > 3 then
                    new_game_field(ity, itx) := dead;
                elsif living_neighbours = 3 then
                    new_game_field(ity, itx) := alive;
                end if;
            end loop;
        end loop;

        game_field := new_game_field;
    end Step_Game;

    function Count_Neighbours (y, x : in Game_Field_Index_t) return Living_Neighbours_t is
        living_neighbours : Living_Neighbours_t := 0;

        iyl               : Natural := Natural(y) - 1;
        iyh               : Natural := Natural(y) + 1;
        ixl               : Natural := Natural(x) - 1;
        ixh               : Natural := Natural(x) + 1;

        procedure incr (self : in out Living_Neighbours_t) is
        begin
            self := self + 1;
        end incr;
    begin
        -- Handle out of range indices
        if iyl = 0 then
            iyl := 1;
        end if;
        if iyh > Natural(Game_Field_Index_t'Last) then
            iyh := Natural(Game_Field_Index_t'Last);
        end if;
        if ixl = 0 then
            ixl := 1;
        end if;
        if ixh > Natural(Game_Field_Index_t'Last) then
            ixh := Natural(Game_Field_Index_t'Last);
        end if;
        -- Count living neighbours
        for ity in iyl .. iyh loop
            for itx in ixl .. ixh loop
                if not ((Game_Field_Index_t(itx) = x) and (Game_Field_Index_t(ity) = y)) then
                    if game_field(Game_Field_Index_t(ity), Game_Field_Index_t(itx)) = alive then
                        incr(living_neighbours);
                    end if;
                end if;
            end loop;
        end loop;

        return living_neighbours;
    end Count_Neighbours;

end Game;
