(* ---- Les Types BEGIN ---- *)
type note_name =
    Do
  | Re
  | Mi
  | Fa
  | Sol
  | La
  | Si

type alteration =
    Becarre
  | Diese

type note = {
  nom: note_name;
  alteration: alteration;
  octave: int;
}
type score =  note list
(* ---- Les Types END ---- *)

(*---------------------*)
(* Les Fonctions BEGIN *)
(*---------------------*)

(* Cré une note en verifiant que la note existe (à compléter/modifier -> je suis pas sure !) *)
let note_factory nom alter octave = 
  if ((nom = Mi) && (alter = Diese))  || ((nom = Si) && (alter = Diese)) then
    { nom = nom; alteration = Becarre; octave = octave; } 
  else
    { nom = nom; alteration = alter; octave = octave; } 

(* converti le nom de la note en String *)
let noteName_to_string noteName = 
  match noteName with
  | Do -> "Do"
  | Re -> "Re"
  | Mi -> "Mi"
  | Fa -> "Fa"
  | Sol -> "Sol"
  | La -> "La"
  | Si -> "Si"

(* Affiche la note avec ses parametres *)
let print_Note_simple note = 
  let (alter:string) = match note.alteration with
    | Becarre -> ""
    | Diese -> "#"
  in
  Printf.printf "%s%d%s" ((noteName_to_string note.nom):string) ((note.octave):int) (alter:string)

(* Retourne la position de la note sans prendre en compte l'alternation *)
let num_Note_nom nom =
  match nom with 
  | Do -> 0
  | Re -> 2
  | Mi -> 4
  | Fa -> 5
  | Sol -> 7
  | La -> 9
  | Si -> 11

(* Retourne la hauteur MIDI de la note *) 
let note2midi note = 
  let numNom = num_Note_nom note.nom in
  let numNomPlusAlter = if note.alteration = Diese then numNom + 1 else numNom in (* +1 si Diese *)
  (24 + 12*(note.octave)) + numNomPlusAlter

(* Calcul de la fréquence grâce à la hauteur MIDI *)
let midi2freq midi = int_of_float (440. *. (2. ** ((float_of_int (midi-69)) /. 12.)))
(* Retourne la fréquence de la note *)
let note2freq note = midi2freq (note2midi note)
(* Affichage de la note avec sa valeur MIDI et sa fréquence *)
let print_Note note = 
  let _ = print_Note_simple note in
  Printf.printf " --> MIDI = %d , fréquence = %d \n" (note2midi note) (note2freq note)

(* Affiche score/partition *)
let print_Score  partition = 
  let _ = Printf.printf "\n"in
  List.iter (fun x ->
    begin
      print_Note_simple x;
      Printf.printf "\n";
    end
  ) partition

(* Joue la note ! *)
(*let play_note note =
  begin
    Graphics.open_graph " 400x600";
    Graphics.sound 440 1000;
    Graphics.set_window_title "Hello";
    Graphics.read_key ();
  end
*)

(*-------------------*)
(* Les Fonctions END *)
(*-------------------*)

let _ = 
  let do_4 = note_factory Do Becarre 4;
  and do_4_diese = note_factory Do Diese 4;
  and la_2 = note_factory La Becarre 2;
  and la_3 = note_factory La Becarre 3;
  and la_4 = note_factory La Becarre 4;
  and mi_3 = note_factory Mi Becarre 3
  in 
  let _ =
    begin
      print_Note do_4 ; 
      print_Note do_4_diese;
      print_Note la_2 ; 
      print_Note la_3;
      print_Note la_4 ; 
      print_Note mi_3; 
    end
  in
  let my_score = [do_4;do_4_diese;la_2;la_3;la_4;mi_3]  in
  let () = print_Score my_score in
  (*let _ = play_note do_4 in*)
  ()
