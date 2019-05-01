open GMain
open GdkKeysyms
open Songs

(* Test Scores MIDI Number *)

let game_of_thrones = [67; 60; 63; 65; 67; 60; 63; 65; 67; 60; 63; 65; 62; 65; 58; 63; 62; 65; 58; 63; 62; 60; 67; 60; 63; 65; 67; 60; 63; 65; 67; 60; 63; 65; 62; 65; 58; 63; 62; 65; 58; 63; 62; 60]
let duration = [1.0; 0.5; 1.0; 0.75; 1.0; 1.25; 0.5; 0.25; 0.5; 1.0; 2.0; 1.5; 1.25; 2.0; 0.25; 0.5; 1.0; 1.25; 1.0; 0.25; 0.5; 0.25; 1.0; 0.5; 1.25; 0.5; 0.25; 1.0; 1.0; 1.0; 1.25; 0.5; 0.25; 1.0; 0.25; 0.5; 1.0; 0.25; 0.5; 1.0; 2.0; 1.0; 1.0; 0.75; 1.0; 1.0; 0.75; 1.0; 1.0; 1.25; 2.0; 1.0; 1.0; 0.5; 2.0; 1.0; 1.0; 1.25; 0.5; 1.0; 1.0; 1.0; 1.5; 2.0]

let locale = GtkMain.Main.init ()

let main () =
  Sdlmixer.open_audio ();
  at_exit Sdlmixer.close_audio;
  let window = GWindow.window ~width:400 ~height:600 ~title:"Improvisation Musicale" () in
  let vbox = GPack.vbox ~packing:window#add () in
  let _ = window#connect#destroy ~callback:Main.quit in ();

  (* Menu bar *)
  let menubar = GMenu.menu_bar ~packing:vbox#pack () in
  let factory = new GMenu.factory menubar in
  let accel_group = factory#accel_group in
  let file_menu = factory#add_submenu "File" in

  (* File menu *)
  let factory = new GMenu.factory file_menu ~accel_group in
  let _ = factory#add_item "Quit" ~key:_Q ~callback: Main.quit in ();   

  (* Button *)
  let button = GButton.button ~label:"Play Music!"
      ~packing:vbox#add () in
  let _ = button#connect#clicked ~callback: (fun () -> play_sound game_of_thrones duration "Game_of_thrones") in ();

  (* Display the windows and enter Gtk+ main loop *)
  window#add_accel_group accel_group;
  window#show ();
  Main.main ()

let () = main ()