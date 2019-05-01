open Types

(* Crée une note en verifiant que la note existe (à compléter/modifier -> je suis pas sure !) *)
let note_factory nom alter octave = 
  if ((nom = Mi) && (alter = Diese))  || ((nom = Si) && (alter = Diese)) then
    { nom = nom; alteration = Becarre; octave = octave; } 
  else
    { nom = nom; alteration = alter; octave = octave; } 


let note_factory_type note type_de_note = {note = note; type_de_note = type_de_note;}
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

  let typeNote_to_string type_de_note = 
  match type_de_note with
  | Noire -> "Noire"
  | Croche -> "Croche"
  | Blanche -> "Blance"
  | NoirePoint -> "NoirePoint"

(* Affiche la note avec ses parametres *)
let print_Note_simple note = 
  let (alter:string) = match note.alteration with
    | Becarre -> ""
    | Diese -> "#"
  in
  Printf.printf "%s%d%s" ((noteName_to_string note.nom):string) ((note.octave):int) (alter:string)

(* Retourne la position de la note sans prendre en compte l'alternation *)
let nomNote2num nom =
  match nom with 
  | Do -> 0
  | Re -> 2
  | Mi -> 4
  | Fa -> 5
  | Sol -> 7
  | La -> 9
  | Si -> 11

(* Retourne la position de la note sans prendre en compte l'alternation *)
let numNote2nom num =
  match num with 
  | 0 -> Do
  | 1 -> Do
  | 2 -> Re 
  | 3 -> Re
  | 4 -> Mi
  | 5 -> Fa
  | 6 -> Fa
  | 7 -> Sol 
  | 8 -> Sol
  | 9 -> La
  | 10 -> La 
  | 11 -> Si
  | _ -> Do

let note_type x note = 
  match note.type_de_note with
  | Noire -> 60.0 /. x
  | Croche -> 0.5 *. (60.0 /. x)
  | Blanche -> 2.0 *. (60.0 /. x)
  | NoirePoint -> 1.5 *. (60.0 /. x)

(* Retourne la hauteur MIDI de la note *) 

let note2midi note = 
  let numNom = nomNote2num note.nom in
  let numNomPlusAlter = if note.alteration = Diese then numNom + 1 else numNom in (* +1 si Diese *)
  (24 + 12*(note.octave)) + numNomPlusAlter

(* Retour la note d'une valeur MIDI *)
let midi2note midi = 
  let octave = (midi - 24) / 12 in
  let numNote = midi - (24 + octave * 12) in
  let nom = numNote2nom numNote in 
  let alter = if (numNote=1 || numNote=3 || numNote=6 || numNote=8 || numNote=10) then Diese else Becarre in
  note_factory nom alter octave

(* Calcul de la fréquence grâce à la hauteur MIDI *)
let midi2freq midi = int_of_float (440. *. (2. ** ((float_of_int (midi-69)) /. 12.)))
(* Retourne la fréquence de la note *)
let note2freq note = midi2freq (note2midi note)
(* Affichage de la note avec sa valeur MIDI et sa fréquence *)
let print_Note note = 
  let _ = print_Note_simple note in
  Printf.printf " --> MIDI = %d , frequence = %d " (note2midi note) (note2freq note)


let print_type_note laNote= 
  let _ = print_Note_simple laNote.note in
  let _ = Printf.printf ", type : %s \n" (typeNote_to_string laNote.type_de_note) in ()


(* Play the note *)
let play_note duration note =
  Graphics.sound (note2freq note) duration

(* MIDI to Note *)
let play_midi duration midi_val =
  begin
    Graphics.sound (midi2freq midi_val) duration;
  end
