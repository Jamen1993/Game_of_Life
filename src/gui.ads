with Gtk.Window;

package Gui is

   procedure init;
   procedure redraw;

private
   main_window : Gtk.Window.Gtk_Window;

   task Gui_Task;

end Gui;
