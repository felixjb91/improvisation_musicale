open Functions
open GMain
open GdkKeysyms

(* Test Scores MIDI Number *)
let ode_to_the_joy = [71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 71; 69; 69; 71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 69; 67; 67; 69; 69; 71; 67; 69; 71; 72; 71; 67; 69; 71; 72; 71; 69; 67; 69; 62; 71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 69; 67; 67]

let game_of_thrones = [67; 60; 63; 65; 67; 60; 63; 65; 67; 60; 63; 65; 62; 65; 58; 63; 62; 65; 58; 63; 62; 60; 67; 60; 63; 65; 67; 60; 63; 65; 67; 60; 63; 65; 62; 65; 58; 63; 62; 65; 58; 63; 62; 60]

let it_crowd = [60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 70; 70; 70; 67; 60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 75; 75;75; 67; 60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 70; 70; 70; 67; 60; 60; 56; 56; 63; 63; 60; 60; 67; 67; 63; 63; 60; 60; 63; 63]
let it_crowd_d = [1.0; 0.5; 1.0; 0.75; 1.0; 1.25; 0.5; 0.25; 0.5; 1.0; 2.0; 1.5; 1.25; 2.0; 0.25; 0.5; 1.0; 1.25; 1.0; 0.25; 0.5; 0.25; 1.0; 0.5; 1.25; 0.5; 0.25; 1.0; 1.0; 1.0; 1.25; 0.5; 0.25; 1.0; 0.25; 0.5; 1.0; 0.25; 0.5; 1.0; 2.0; 1.0; 1.0; 0.75; 1.0; 1.0; 0.75; 1.0; 1.0; 1.25; 2.0; 1.0; 1.0; 0.5; 2.0; 1.0; 1.0; 1.25; 0.5; 1.0; 1.0; 1.0; 1.5; 2.0]

(* Test Scores Frequency *)
let ode_to_the_joy_freq = midi_to_freq_score ode_to_the_joy
let game_of_thrones_freq = midi_to_freq_score game_of_thrones
let it_crowd_freq = midi_to_freq_score it_crowd

let locale = GtkMain.Main.init ()

(* Play Sound *)
let play_sound notes duration song_name =
  let _ = wav_data 44100 1.0 notes duration song_name in
  let music_filename = Sys.getcwd () ^ "/" ^ song_name ^ ".wav" in
  let music = Sdlmixer.load_music music_filename in ();
  Sdlmixer.fadein_music music 1.0;
  Sdltimer.delay 1000; (* fade in *)
  Sdltimer.delay 60000; (* play *)
  Sdlmixer.fadeout_music 2.0;
  Sdltimer.delay 2000; (* fade out *)
  Sdlmixer.halt_music ();
  Sdlmixer.free_music music

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
  let _ = button#connect#clicked ~callback: (fun () -> play_sound game_of_thrones it_crowd_d "it_crowd") in ();

  (* Display the windows and enter Gtk+ main loop *)
  window#add_accel_group accel_group;
  window#show ();
  Main.main ()

let () = main ()