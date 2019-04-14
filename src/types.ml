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

let noteName_to_string noteName = 
  match noteName with
  | Do -> "Do"
  | Re -> "Re"
  | Mi -> "Mi"
  | Fa -> "Fa"
  | Sol -> "Sol"
  | La -> "La"
  | Si -> "Si"

let affiche_Note_simple note = 
  let (alter:string) = match note.alteration with
    | Becarre -> ""
    | Diese -> "#"
  in
  Printf.printf "%s%d%s" ((noteName_to_string note.nom):string) ((note.octave):int) (alter:string)

let num_Note_nom nom =
  match nom with 
  | Do -> 0
  | Re -> 2
  | Mi -> 4
  | Fa -> 5
  | Sol -> 7
  | La -> 9
  | Si -> 11


let note2midi note = 
  let numNom = num_Note_nom note.nom in
  let numNomPlusAlter = if note.alteration = Diese then numNom + 1 else numNom in 
  (24 + 12*(note.octave)) + numNomPlusAlter


let midi2freq midi = int_of_float (440. *. (2. ** ((float_of_int (midi-69)) /. 12.)))

let note2freq note = midi2freq (note2midi note)


let affiche_Note note = 
  let _ = affiche_Note_simple note in
  Printf.printf " --> MIDI = %d , fréquence = %d \n" (note2midi note) (note2freq note)


let _ = 
  let do_4 = {
    nom = Do;
    alteration = Becarre;
    octave = 4;
  } and do_4_diese = {
    nom = Do;
    alteration = Diese;
    octave = 4;
  } and la_2 = {
    nom = La;
    alteration = Becarre;
    octave = 2;
  } and la_3 = {
    nom = La;
    alteration = Becarre;
    octave = 3;
  }and la_4 = {
    nom = La;
    alteration = Becarre;
    octave = 4;
  }and mi_3 = {
    nom = Mi;
    alteration = Becarre;
    octave = 3;
  }
  in 
  let _ =
    begin
      affiche_Note do_4 ; 
      affiche_Note do_4_diese;
      affiche_Note la_2 ; 
      affiche_Note la_3;
      affiche_Note la_4 ; 
      affiche_Note mi_3; 
    end
  in
  ()
