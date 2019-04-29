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
  duree: float;
}

type type_de_note =
   Noire
  | Croche
  | Blanche
  | NoirePoint

type note = {
  nom: note_name;
  alteration: alteration;
  octave: int;
  type_de_note: type_de_note;
}

type type_de_note =
  | Noire
  | Croche
  | Blanche
  | NoirePoint

type types_note = {
  nom: note_name;
  alteration: alteration;
  octave: int;
  type_de_note: type_de_note;
}

type score =  note list

type arpege = 
    Montant
  | Descendant
  | LesDeux

type 'a tree = 
    Empty
  | Tree of 'a * int * ('a tree list)

(* ---- Les Types END ---- *)

(*---------------------*)
(* Les Fonctions BEGIN *)
(*---------------------*)

(* Crée une note en verifiant que la note existe (à compléter/modifier -> je suis pas sure !) *)
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
  Printf.printf " --> MIDI = %d , frequence = %d \n" (note2midi note) (note2freq note)

(* Affiche score/partition *)
let print_Score  partition = 
  let _ = Printf.printf "\n"in
  List.iter (fun x ->
      begin
        print_Note_simple x;
        Printf.printf "\n";
      end
    ) partition

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
  let _ = print_Score my_score in

  let my_arpege_montant = arpergie Montant 48 4 7 3 in
  let my_arpege_descendant = arpergie Descendant 84 4 7 3 in
  let my_arpege_lesDeux = arpergie LesDeux 48 4 7 3 in

  let _ =
    begin
      Printf.printf "\n";
      List.iter (fun x -> Printf.printf "%d " x) my_arpege_montant;
      Printf.printf "\n";
      List.iter (fun x -> Printf.printf "%d " x) my_arpege_descendant;
      Printf.printf "\n";
      List.iter (fun x -> Printf.printf "%d " x) my_arpege_lesDeux;
    end
  in
  ()
