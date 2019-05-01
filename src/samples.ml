open Types
open Functions

(* Example: Declaring simple Notes *)
let do_4 = note_factory Do Becarre 4
and do_4_diese = note_factory Do Diese 4
and la_2 = note_factory La Becarre 2
and la_3 = note_factory La Becarre 3
and la_4 = note_factory La Becarre 4
and mi_3 = note_factory Mi Becarre 3

(* Example: GUI using Graphics Module to play the Notes *)
let _ =
  begin
    Graphics.open_graph " 400x600";
    Graphics.set_window_title "Improvisation Musicale";
    play_note 100 do_4;
    play_note 300 do_4_diese;
    play_note 500 la_2;
    play_note 600 la_3;
    play_note 100 mi_3;
    play_note 200 la_4;
    Graphics.read_key ();
  end

(* Test Scores MIDI Number *)
let game_of_thrones = [67; 60; 63; 65; 67; 60; 63; 65; 67; 60; 63; 65; 62; 65; 58; 63; 62; 65; 58; 63; 62; 60; 67; 60; 63; 65; 67; 60; 63; 65; 67; 60; 63; 65; 62; 65; 58; 63; 62; 65; 58; 63; 62; 60]
let ode_to_the_joy = [71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 71; 69; 69; 71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 69; 67; 67; 69; 69; 71; 67; 69; 71; 72; 71; 67; 69; 71; 72; 71; 69; 67; 69; 62; 71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 69; 67; 67]
let it_crowd = [60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 70; 70; 70; 67; 60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 75; 75;75; 67; 60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 70; 70; 70; 67; 60; 60; 56; 56; 63; 63; 60; 60; 67; 67; 63; 63; 60; 60; 63; 63]

(* Test Scores Frequency *)
let ode_to_the_joy_freq = midi_to_freq_score ode_to_the_joy
let game_of_thrones_freq = midi_to_freq_score game_of_thrones
let it_crowd_freq = midi_to_freq_score it_crowd

(* Example: Play a MIDI list using Graphics.sound *)
let _ =
  begin
    Graphics.set_window_title "Hello";
    Graphics.set_window_title "Improvisation Musicale";
    List.iter (fun x -> Graphics.sound x 500) ode_to_the_joy_freq;
    Graphics.read_key ();
  end