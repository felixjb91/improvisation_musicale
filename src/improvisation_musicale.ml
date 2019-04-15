open Types
open Functions

(* Notes to play *)
let do_4 = note_factory Do Becarre 4
  and do_4_diese = note_factory Do Diese 4
  and la_2 = note_factory La Becarre 2
  and la_3 = note_factory La Becarre 3
  and la_4 = note_factory La Becarre 4
  and mi_3 = note_factory Mi Becarre 3

let _ =
  begin
    Graphics.open_graph " 400x600";
    Graphics.sound 440 1000;
    play_note do_4 100;
    play_note do_4_diese 300;
    play_note la_2 500;
    play_note la_3 600;
    play_note mi_3 100;
    play_note la_4 200;
    Graphics.set_window_title "Hello";
    Graphics.read_key ();
  end