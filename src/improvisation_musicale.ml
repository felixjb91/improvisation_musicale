open GMain
open GdkKeysyms
open Songs

let locale = GtkMain.Main.init ()

let main () =
  Sdlmixer.open_audio ();
  at_exit Sdlmixer.close_audio;
  let window = GWindow.window ~width:400 ~height:600 ~title:"Improvisation Musicale" () in
  let vbox = GPack.vbox ~packing:window#add
      ~height:10
      ~width:10 () in
  let _ = window#connect#destroy ~callback:Main.quit in ();

  (* Menu bar *)
  let menubar = GMenu.menu_bar ~packing:vbox#pack () in
  let factory = new GMenu.factory menubar in
  let accel_group = factory#accel_group in
  let file_menu = factory#add_submenu "File" in

  (* File menu *)
  let factory = new GMenu.factory file_menu ~accel_group in
  let _ = factory#add_item "Quit" ~key:_Q ~callback: Main.quit in ();

  (* Horizontal Box *)
  let hbox = GPack.hbox 
      ~packing:vbox#add
      ~height:10
      ~width:10 () in

  (* Play Game of Thrones Theme Music *)
  let button = GButton.button ~label:"Game of thrones"
      ~packing:hbox#add () in
  let notes_list, duration_list = (Scores.scoreTypedNote2doubleList Samplemusic.game_of_thrones 120.0) in
  let _ = button#connect#clicked ~callback: (fun () -> play_sound notes_list duration_list "Game_of_thrones") in ();

  (* Play Ode to Joy Music Simple Version *)
  let button = GButton.button ~label:"Ode to joy!"
      ~packing:hbox#add () in
  let notes_list, duration_list = (Scores.scoreTypedNote2doubleList Samplemusic.ode_to_joy 120.0) in
  let _ = button#connect#clicked ~callback: (fun () -> play_sound notes_list duration_list "Ode_to_joy") in ();

  (* Button to open Input Text Dialog *)
  let s = "Compose Music" in
  let button = GButton.button ~label:"Create your song!" ~packing:vbox#add () in
  let _ = button#connect#clicked 
      ~callback: (fun () -> 
          match GToolbox.input_text ~title:s s with 
          | Some text -> let notes_list, duration_list = (Scores.scoreTypedNote2doubleList (Gui.typed_note_list_of_string text) 120.0) in
            let _ = play_sound notes_list duration_list "User Notes" in ()
          | None -> ()) in ();

  (* Display the windows and enter Gtk+ main loop *)
  window#add_accel_group accel_group;
  window#show ();
  Main.main ()

let () = main ()