(* ---- BEGIN Types ---- *)

(* Name of a Note *)
type note_name =
    Do
  | Re
  | Mi
  | Fa
  | Sol
  | La
  | Si
  | Rest

(* Pitch of a Note - Natural or Sharp *)
type alteration =
    Becarre 
  | Diese

(* Note *)
type note = {
  nom: note_name;
  alteration: alteration;
  octave: int;
}

(* Type of a Note *)
type type_de_note =
    Noire
  | Croche
  | Blanche
  | NoirePoint

(* Note with Type *)
type typed_note = {
  note: note;
  type_de_note: type_de_note;
}

(* List of Notes *)
type score =  note list

(* List of Typed Notes *)
type score_typed_notes = typed_note list

(* Arpeggio *)
type arpege = 
    Montant
  | Descendant
  | LesDeux

(* Tree for LZW Compression *)
type 'a tree = 
    Empty
  | Tree of 'a * int * ('a tree list)

(* ---- Les Types END ---- *)