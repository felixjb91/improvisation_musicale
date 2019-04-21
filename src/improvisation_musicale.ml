open Functions

(* Test Scores MIDI Number *)
let ode_to_the_joy = [71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 71; 69; 69; 71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 69; 67; 67; 69; 69; 71; 67; 69; 71; 72; 71; 67; 69; 71; 72; 71; 69; 67; 69; 62; 71; 71; 72; 74; 74; 72; 71; 69; 67; 67; 69; 71; 69; 67; 67]

let game_of_thrones = [67; 60; 63; 65; 67; 60; 63; 65; 67; 60; 63; 65; 62; 65; 58; 63; 62; 65; 58; 63; 62; 60; 67; 60; 63; 65; 67; 60; 63; 65; 67; 60; 63; 65; 62; 65; 58; 63; 62; 65; 58; 63; 62; 60]

let it_crowd = [60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 70; 70; 70; 67; 60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 75; 75;75; 67; 60; 60; 60; 67; 63; 63; 63; 70; 67; 67; 67; 74; 70; 70; 70; 67; 60; 60; 56; 56; 63; 63; 60; 60; 67; 67; 63; 63; 60; 60; 63; 63]

(* Test Scores Frequency *)
let ode_to_the_joy_freq = midi_to_freq_score ode_to_the_joy
let game_of_thrones_freq = midi_to_freq_score game_of_thrones
let it_crowd_freq = midi_to_freq_score it_crowd

let _ =
  begin
    Graphics.open_graph " 400x600";
    Graphics.set_window_title "Improvisation Musicale";
    List.iter (fun x -> Graphics.sound x 500) ode_to_the_joy_freq;
    Graphics.read_key ();
  end