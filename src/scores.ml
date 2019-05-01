open Types
open Notes

(* Crée un arpège sur la base d'une "basse" en valeur MIDI et de deux intervalles *)
(* Un arpège peut être croissant, décroissant ou croissant puis décroissant*)
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
let midi_to_freq_score midi_score =
  let rec aux acc l =
    match l with
    | element_1::sub_list -> 
      let acc = aux acc sub_list in
      let x = midi2freq element_1 in
      x::acc
    | _ -> []
  in aux [] midi_score


(* Play a score MIDI - Exercise 2.3 *)
let play_score_midi score =
  List.iter (play_midi 250) score

(* Play a score *)
let play_score score =
  List.iter (play_note 1000) score

(* transpose *)
let transpose score intervalle = 
  List.map (fun note -> midi2note ((note2midi note) + intervalle)) score
