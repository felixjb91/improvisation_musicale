open Types

(* Create a Note *)
let note_factory nom alter octave = 
  if ((nom = Mi) && (alter = Diese))  || ((nom = Si) && (alter = Diese)) then
    { nom = nom; 
      alteration = Becarre; 
      octave = octave; } 
  else
    { nom = nom; 
      alteration = alter; 
      octave = octave; } 

(* Create a Typed Note *)
let note_factory_type note type_de_note = 
  { note = note; 
    type_de_note = type_de_note; }

(* Convert Note to String *)
let noteName_to_string noteName = 
  match noteName with
  | Do -> "Do"
  | Re -> "Re"
  | Mi -> "Mi"
  | Fa -> "Fa"
  | Sol -> "Sol"
  | La -> "La"
  | Si -> "Si"
  | Rest -> "Rest"

(* String to Note *)
let string_to_noteName str = 
  match str with
  | "Do" -> Do
  | "Re" -> Re
  | "Mi" -> Mi
  | "Fa" -> Fa
  | "Sol" -> Sol
  | "La" -> La
  | "Si" -> Si
  | _ -> Rest

(* String to Alteration *)
let string_to_alteration str =
  match str with
  | "Becarre" -> Becarre
  | "Diese" -> Diese
  | _ -> Becarre

(* Convert Type of a Note to String *)
let typeNote_to_string type_de_note = 
  match type_de_note with
  | Noire -> "Noire"
  | Croche -> "Croche"
  | Blanche -> "Blanche"
  | NoirePoint -> "NoirePoint"

(* Convert String to Type of a Note *)
let string_to_noteType str = 
  match str with
  | "Noire" -> Noire
  | "Croche" -> Croche
  | "Blanche" -> Blanche
  | "NoirePoint" -> NoirePoint
  | _ -> Noire

(* Print a Note with its parameters *)
let print_Note_simple note = 
  let (alter:string) = match note.alteration with
    | Becarre -> ""
    | Diese -> "#"
  in
  Printf.printf "%s%d%s" ((noteName_to_string note.nom):string) ((note.octave):int) (alter:string)

(* Return the position of a note regardless of its alteration *)
let nomNote2num nom =
  match nom with 
  | Do -> 0
  | Re -> 2
  | Mi -> 4
  | Fa -> 5
  | Sol -> 7
  | La -> 9
  | Si -> 11
  | Rest -> -1

(* Return the name of the Note *)
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
  | _ -> Rest

(* Get the duration of a Note in seconds *)
let noteType2duree x note = 
  match note.type_de_note with
  | Noire -> 60.0 /. x
  | Croche -> 0.5 *. (60.0 /. x)
  | Blanche -> 2.0 *. (60.0 /. x)
  | NoirePoint -> 1.5 *. (60.0 /. x)

(* Return MIDI value of a Note *)
let note2midi note =
  match note.nom with
  | Rest -> 0
  | _ -> let numNom = nomNote2num note.nom in
    let numNomPlusAlter = if note.alteration = Diese then numNom + 1 else numNom in (* +1 si Diese *)
    (24 + 12*(note.octave)) + numNomPlusAlter

(* Return the Note of a MIDI value *)
let midi2note midi = 
  let octave = (midi - 24) / 12 in
  let numNote = midi - (24 + octave * 12) in
  let nom = numNote2nom numNote in 
  let alter = if (numNote=1 || numNote=3 || numNote=6 || numNote=8 || numNote=10) then Diese else Becarre in
  note_factory nom alter octave

(* Calculate the frequency of a MIDI value *)
let midi2freq midi = int_of_float (440. *. (2. ** ((float_of_int (midi-69)) /. 12.)))


(* Return the frequency of a Note *)
let note2freq note = midi2freq (note2midi note)

(* Print MIDI value and frequency of a Note *)
let print_Note note = 
  let _ = print_Note_simple note in
  Printf.printf " --> MIDI = %d , frequence = %d " (note2midi note) (note2freq note)

(* Print a Typed Note *)
let print_type_note laNote = 
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
