open Types

(* Play the note *)
let play_note duration note =
  Graphics.sound (note2freq note) duration

(* Convert MIDI list to Frequency list *)
let midi_to_freq_score midi_score =
  let rec aux acc l =
    match l with
    | element_1::sub_list -> 
      let acc = aux acc sub_list in
      let x = midi2freq element_1 in
      x::acc
    | _ -> []
  in aux [] midi_score

(* MIDI to Note *)
let play_midi duration midi_val =
  begin
  Graphics.sound (midi2freq midi_val) duration;
  end

(* Play a score MIDI - Exercise 2.3 *)
let play_score_midi score =
  List.iter (play_midi 250) score

(* Play a score *)
let play_score score =
  List.iter (play_note 1000) score

(* transpose *)
let transpose score intervalle = 
  List.map (fun note -> midi2note ((note2midi note) + intervalle)) score

