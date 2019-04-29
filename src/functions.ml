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

(* Create Song *)
let create_song song_name sample_rate data =
  let channels = 2 in
  let wav = new Audio.IO.Writer.to_wav_file channels sample_rate (song_name^".wav") in
  let buffer_length = 1024 in
  let buffer = Audio.create channels buffer_length in
  List.iter (fun x -> 
      match x with 
      | (_, samples, generator) -> 
        for _ = 0 to samples / buffer_length -1 do
          generator#fill buffer 0 buffer_length;
          wav#write buffer 0 buffer_length;
        done;) data;
  wav#close

(* Get Sample *)
let get_samples sample_rate duration =
  (float_of_int sample_rate) *. duration

(* Sine *)
let sine sample_rate gain freq duration =
  let samples = get_samples sample_rate duration in
  let generator = new Audio.Generator.of_mono 
    (new Audio.Mono.Generator.sine 
      ~volume:gain sample_rate (float_of_int freq)) in
  sample_rate, (int_of_float samples), generator

(* Recursively create wavform data *)
let wav_data sample_rate gain freq duration song_name =
  let data =
    let rec aux f d acc =
      match (f, d) with
      | (x::s_f, y::s_d) ->  aux s_f s_d (acc@[sine sample_rate gain x y])
      | (_, _) ->  acc@[sine sample_rate 0.0 0 0.0] in
    aux (midi_to_freq_score freq) duration [] in
  let _ = Printf.printf "Length = %d" (List.length data) in
  create_song song_name sample_rate data