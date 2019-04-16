open Types
open Functions

let do_4 = note_factory Do Becarre 4
  and do_4_diese = note_factory Do Diese 4
  and la_2 = note_factory La Becarre 2
  and la_3 = note_factory La Becarre 3
  and la_4 = note_factory La Becarre 4
  and mi_3 = note_factory Mi Becarre 3

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