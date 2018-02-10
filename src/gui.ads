with Gtk.Window;
with Gtk.Drawing_Area;

package Gui is

   procedure init;
   procedure redraw;

private
   main_window : Gtk.Window.Gtk_Window;
   drawing_area : Gtk.Drawing_Area.Gtk_Drawing_Area;

   task gui_task;

end Gui;
