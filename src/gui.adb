with Ada.Real_Time; use Ada.Real_Time;

with Gdk.Color;
with Gtk.Main;
with Gtk.Enums;
with Gtk.Drawing_Area;

package body Gui is

   procedure init is
         bg_color : Gdk.Color.Gdk_Color;
   begin
      Gtk.Main.Init;

      Gtk.Window.Gtk_New (Window => main_window, The_Type => Gtk.Enums.Window_Toplevel);
      main_window.Set_Title ("Conways Game of Life");
      main_window.Set_Border_Width (4);
      main_window.Set_Resizable (False);

      Gdk.Color.Set_Rgb (bg_color, 44028, 49341, 0);
      main_window.Modify_Bg (Gtk.Enums.State_Normal, bg_color);

      --Gtk.Drawing_Area.Gtk_New

      main_window.Show_All;
   end init;

   procedure redraw is
   begin
      null;
   end redraw;

   task body Gui_Task is
      TASK_PERIOD : constant Time_Span := Milliseconds (100);
      next_time : Time := Clock;
   begin
      init;

      loop
         Gtk.Main.Main;

         next_time := next_time + TASK_PERIOD;
         delay until next_time;
      end loop;
   end Gui_task;

end Gui;
