open Scores

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

(* Play a song *)
let play_sound notes duration song_name =
  let _ = wav_data 44100 1.0 notes duration song_name in
  let music_filename = Sys.getcwd () ^ "/" ^ song_name ^ ".wav" in
  let music = Sdlmixer.load_music music_filename in ();
  Sdlmixer.fadein_music music 1.0;
  Sdltimer.delay 1000; (* fade in *)
  Sdltimer.delay (int_of_float((List.fold_left (fun x y -> x +. y) 0.0 duration)*.100.0)); (* play *)
  Sdlmixer.fadeout_music 2.0;
  Sdltimer.delay 2000; (* fade out *)
  Sdlmixer.halt_music ();
  Sdlmixer.free_music music