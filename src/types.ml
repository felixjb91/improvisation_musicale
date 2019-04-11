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

let _ = 
  let do_4 = {
    nom = Do;
    alteration = Becarre;
    octave = 4;
  } and do_4_diese = {
    nom = Do;
    alteration = Diese;
    octave = 4;
  } in ()