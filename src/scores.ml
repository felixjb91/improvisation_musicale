open Types
open Notes

(* Creating an Arpeggio *)
let arpergie arpe basse itv1 itv2 nbOctave =
  let rec aux acc cptOct arpe =
    if cptOct=0 then
      acc
    else
    if (arpe = Montant) then 
      let acc = ((List.hd acc) - (12-itv2))::acc in
      let acc = ((List.hd acc) - (itv2-itv1))::acc in
      let acc = ((List.hd acc) - itv1)::acc in
      aux acc (cptOct-1) arpe
    else
      let acc = ((List.hd acc) + itv1)::acc in
      let acc = ((List.hd acc) + (itv2-itv1))::acc in
      let acc = ((List.hd acc) + (12-itv2))::acc in
      aux acc (cptOct-1) arpe
  in
  match arpe with
  | Montant -> aux [basse+nbOctave*12] nbOctave Montant
  | Descendant -> aux [basse-nbOctave*12] nbOctave Descendant
  | LesDeux -> 
    let res = aux [basse] nbOctave Descendant in
    let res = (basse+nbOctave*12)::res in
    aux res nbOctave Montant

(* Convert MIDI list to Frequency list *)
let midi_to_freq_score midi_score = List.map (fun x -> midi2freq x) midi_score

(* Convert Note list to MIDI list *)
let note_to_midi_score score= List.map (fun x -> note2midi x) score

(* Play a score MIDI - Exercise 2.3 *)
let play_score_midi score =
  List.iter (play_midi 250) score

(* Play a score *)
let play_score score =
  List.iter (play_note 1000) score

(* Transpose *)
let transpose score intervalle = 
  List.map (fun note -> midi2note ((note2midi note) + intervalle)) score

(* Split Typed Note into Note List and Duration List *)
let scoreTypedNote2doubleList scoreT bpm = 
  let listM = List.map (fun typedNote -> note2midi typedNote.note) scoreT in
  let listD = List.map (fun typedNote -> noteType2duree bpm typedNote) scoreT in
  listM, listD