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


(* Audio *)

let create_song song_name sample_rate samples generator =
  let channels = 2 in
  let wav = new Audio.IO.Writer.to_wav_file channels sample_rate (song_name^".wav") in
  let buffer_length = 1024 in
  let buffer = Audio.create channels buffer_length in
  for _ = 0 to samples / buffer_length -1 do
    generator#fill buffer 0 buffer_length;
    wav#write buffer 0 buffer_length;
  done;
  wav#close

let get_samples sample_rate duration =
  (float_of_int sample_rate) *. duration

let sine sample_rate gain freq duration song_name =
  let samples = get_samples sample_rate (float_of_int duration) in
  let generator = new Audio.Generator.of_mono 
    (new Audio.Mono.Generator.sine 
      ~volume:gain sample_rate (float_of_int freq)) in
  create_song song_name sample_rate (int_of_float samples) generator